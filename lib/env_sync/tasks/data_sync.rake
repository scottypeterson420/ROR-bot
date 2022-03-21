desc 'Starting point for data sync'
task data_sync: :environment do
  abort 'Forbidden to run in this environment' unless EnvSync.config.permitted_environments.include?(Rails.env)

  step_definitions_file_path = Rails.root.join(ENV['SETTINGS_FILE_PATH'])
  unless step_definitions_file_path && File.exist?(step_definitions_file_path)
    abort 'Invalid or missing step_definitions file path'
  end

  EnvSync.step_definitions.load_step_definitions_file(step_definitions_file_path)
  abort 'Missing steps in config' unless EnvSync.step_definitions.steps

  EnvSync.step_definitions.steps.each_key do |step_name|
    step_class = EnvSync::StepFactory.new(step_name).build
    step_definition = EnvSync.step_definitions.steps[step_name.to_sym]
    step = step_class.new(step_definition)

    puts "Started step: #{step_name}"
    step.run

    abort step.message unless step.success

    puts step.message
  end
end
