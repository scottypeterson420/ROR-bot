RSpec.describe EnvSync::Steps::DownloadRemoteDbDump do
  subject(:step) { described_class.new(step_settings) }

  let(:settings) { EnvSync::Settings.new }
  let(:loaded_settings) { settings.load_settings_file('spec/support/settings_with_all_steps.yml') }
  let(:step_settings) { loaded_settings.dig(:steps, :download_remote_db_dump) }

  context 'when the S3 credentials are missing' do
    before { loaded_settings[:steps][:download_remote_db_dump].delete(:s3_credentials) }

    it 'does not execute the command' do
      command = successful_command_stub

      step.run

      expect(command).not_to have_received(:execute)
    end

    it 'sets the message' do
      step.run

      expect(step.message).to eq('Missing S3 credentials in config')
    end

    it 'does not update the success variable' do
      step.run

      expect(step.success).to be false
    end
  end

  context 'when the S3 credentials are present' do
    it 'downloads the S3 object' do
      s3_object = s3_object_stub

      step.run

      expect(s3_object).to have_received(:download_file)
    end

    it 'sets the message' do
      s3_object_stub

      step.run

      expect(step.message).to include('downloaded')
    end

    it 'sets the success variable' do
      s3_object_stub

      step.run

      expect(step.success).to be true
    end
  end
end
