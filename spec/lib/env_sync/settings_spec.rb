RSpec.describe EnvSync::Settings do
  subject(:settings) { described_class.new }

  describe '#loaded_settings' do
    it 'returns a hash with the contents of the settings file' do
      settings.load_settings_file('spec/support/settings_with_all_steps.yml')

      expect(settings.loaded_settings).to be_a(Hash)
      expect(settings.loaded_settings.keys).to match_array([:steps])
    end
  end

  describe '#steps' do
    it 'returns the steps with step settings from the settings file' do
      steps = [
        :download_remote_db_dump,
        :create_local_db_backup,
        :reset_local_db_schema,
        :import_remote_db_to_local_db,
        :run_migrations_on_local_db,
        :delete_remote_db_dump,
        :execute_custom_command
      ]

      settings.load_settings_file('spec/support/settings_with_all_steps.yml')

      expect(settings.steps).to be_a(Hash)
      expect(settings.steps.keys).to match_array(steps)
    end
  end

  describe '#run_step?' do
    it 'returns true if the step should be run according to the settings file' do
      settings.load_settings_file('spec/support/settings_with_all_steps.yml')

      expect(settings.run_step?(:download_remote_db_dump)).to be true
    end

    it 'returns false if the step should not be run according to the settings file' do
      settings.load_settings_file('spec/support/settings_without_all_steps.yml')

      expect(settings.run_step?(:delete_remote_db_dump)).to be false
    end
  end

  describe '#remote_db_dump_file_path' do
    it 'returns the remote DB dump file path for the import step if it exists' do
      settings.load_settings_file('spec/support/settings_with_all_steps.yml')

      expect(settings.remote_db_dump_file_path).to eq('./tmp/staging.sql')
    end

    it 'returns the remote DB dump download path if the file path for the import step has not been specified' do
      settings.load_settings_file('spec/support/settings_without_all_steps.yml')

      expect(settings.remote_db_dump_file_path).to eq('./tmp/downloaded_db_dump.sql')
    end
  end
end
