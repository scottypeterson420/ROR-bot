RSpec.describe EnvSync::StepDefinitions do
  subject(:step_definitions) { described_class.new }

  describe '#loaded_step_definitions' do
    it 'returns a hash with the contents of the step definitions file' do
      step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')

      expect(step_definitions.loaded_step_definitions).to be_a(Hash)
      expect(step_definitions.loaded_step_definitions.keys).to match_array([:steps])
    end
  end

  describe '#steps' do
    it 'returns the steps with step definitions from the step_definitions file' do
      steps = [
        :download_remote_db_dump,
        :create_local_db_backup,
        :reset_local_db_schema,
        :import_remote_db_to_local_db,
        :run_migrations_on_local_db,
        :delete_remote_db_dump,
        :execute_custom_command
      ]

      step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')

      expect(step_definitions.steps).to be_a(Hash)
      expect(step_definitions.steps.keys).to match_array(steps)
    end
  end
end
