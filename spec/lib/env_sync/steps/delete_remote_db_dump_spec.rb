RSpec.describe EnvSync::Steps::DeleteRemoteDbDump do
  subject(:step) { described_class.new(step_definition) }

  let(:step_definitions) { EnvSync::StepDefinitions.new }
  let(:loaded_step_definitions) do
    step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')
  end
  let(:step_definition) { loaded_step_definitions.dig(:steps, :delete_remote_db_dump) }

  before do
    allow(File).to receive(:delete)
  end

  context 'when the file is valid' do
    before do
      allow(File).to receive(:exist?).and_return(true)
    end

    it 'deletes the file' do
      step.run

      expect(File).to have_received(:delete)
    end

    it 'sets the message' do
      step.run

      expect(step.message).to include('Deleted file')
    end

    it 'sets the success variable' do
      step.run

      expect(step.success).to be true
    end
  end

  context 'when the file is not valid' do
    it 'does not delete the file' do
      step.run

      expect(File).not_to have_received(:delete)
    end

    it 'sets the message' do
      step.run

      expect(step.message).to eq('Missing remote DB dump file')
    end

    it 'does not update the success variable' do
      step.run

      expect(step.success).to be false
    end
  end
end
