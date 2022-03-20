desc 'Starting point for data sync'
task :data_sync, [:settings_file_path] => :environment do |_, args|
  abort 'Forbidden to run in this environment' unless EnvSync.config.permitted_environments.include?(Rails.env)

  settings_file_path = Rails.root.join(args[:settings_file_path])
  abort 'Invalid or missing settings file path' unless settings_file_path && File.exist?(settings_file_path)

  EnvSync.settings.load_settings_file(settings_file_path)
  abort 'Missing steps in config' unless EnvSync.settings.steps

  EnvSync.settings.steps.each_key do |step_name|
    step_class = StepFactory.new(step_name).build
    step_settings = EnvSync.settings.steps[step_name.to_sym]
    step = step_class.new(step_settings)
    step.run

    abort step.message unless step.success

    puts step.message
  end
end
