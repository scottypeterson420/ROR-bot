RSpec.describe CopyBot::StepDefinitions do
  subject(:step_definitions) { described_class.new }

  describe '#loaded_step_definitions' do
    it 'returns a hash with the contents of the step definitions file' do
      step_definitions.load_step_definitions_file('spec/support/step_definitions.yml')

      expect(step_definitions.loaded_step_definitions).to be_a(Hash)
      expect(step_definitions.loaded_step_definitions.keys).to match_array([:steps])
    end
  end
end
