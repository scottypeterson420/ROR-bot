desc 'Starting point for data sync'
task copy_bot: :environment do
  logger = CopyBot.config.logger

  unless CopyBot.config.permitted_environments.include?(Rails.env)
    logger.debug('Forbidden to run in this environment')
    abort
  end

  step_definitions_file_path = Rails.root.join(ENV['STEP_DEFINITIONS_FILE_PATH'])
  unless step_definitions_file_path && File.exist?(step_definitions_file_path)
    logger.debug('Invalid or missing step_definitions file path')
    abort
  end

  CopyBot.step_definitions.load_step_definitions_file(step_definitions_file_path)
  unless CopyBot.step_definitions.steps
    logger.debug('Missing steps in config')
    abort
  end

  CopyBot.step_definitions.steps.each_key do |step_name|
    success = CopyBot::StepRunner.new(step_name).call
    abort unless success
  end
end
