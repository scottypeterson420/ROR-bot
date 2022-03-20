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
end
