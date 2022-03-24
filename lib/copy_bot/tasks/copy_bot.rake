desc 'Starting point for data sync'
task copy_bot: :environment do
  abort 'Forbidden to run in this environment' unless CopyBot.config.permitted_environments.include?(Rails.env)

  step_definitions_file_path = Rails.root.join(ENV['SETTINGS_FILE_PATH'])
  unless step_definitions_file_path && File.exist?(step_definitions_file_path)
    abort 'Invalid or missing step_definitions file path'
  end

  CopyBot.step_definitions.load_step_definitions_file(step_definitions_file_path)
  abort 'Missing steps in config' unless CopyBot.step_definitions.steps

  CopyBot.step_definitions.steps.each_key do |step_name|
    step_class = CopyBot::StepFactory.new(step_name).build
    step_definition = CopyBot.step_definitions.steps[step_name.to_sym]
    step = step_class.new(step_definition)

    puts "Started step: #{step_name}"
    step.run

    abort step.message unless step.success

    puts step.message
  end
end
