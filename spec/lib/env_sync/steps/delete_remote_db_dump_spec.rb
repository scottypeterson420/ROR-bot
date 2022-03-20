RSpec.describe EnvSync::Steps::DeleteRemoteDbDump do
  subject(:step) { described_class.new(step_settings) }

  let(:settings) { EnvSync::Settings.new }
  let(:loaded_settings) { settings.load_settings_file('spec/support/settings_with_all_steps.yml') }
  let(:step_settings) { loaded_settings.dig(:steps, :delete_remote_db_dump) }

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
