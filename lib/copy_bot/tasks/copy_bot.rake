desc 'Starting point for data sync'
task copy_bot: :environment do
  logger = CopyBot.config.logger

  unless CopyBot.config.permitted_environments.include?(Rails.env)
    exit logger.debug('Forbidden to run in this environment')
  end

  step_definitions_file_path = Rails.root.join(ENV['SETTINGS_FILE_PATH'])
  unless step_definitions_file_path && File.exist?(step_definitions_file_path)
    exit logger.debug('Invalid or missing step_definitions file path')
  end

  CopyBot.step_definitions.load_step_definitions_file(step_definitions_file_path)
  exit logger.debug('Missing steps in config') unless CopyBot.step_definitions.steps

  CopyBot.step_definitions.steps.each_key do |step_name|
    success = CopyBot::StepRunner.new(step_name).call
    exit unless success
  end
end
