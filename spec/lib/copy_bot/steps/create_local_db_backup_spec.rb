RSpec.describe CopyBot::Steps::CreateLocalDbBackup do
  subject(:step) { described_class.new(step_definitions.steps[:create_local_db_backup]) }

  let(:step_definitions) { CopyBot.step_definitions }

  before do
    step_definitions.load_step_definitions_file('spec/support/step_definitions.yml')
    db_conn_config_stub
  end

  it 'executes the command' do
    command = shell_command_stub(success: true)

    step.run

    expect(command).to have_received(:execute)
  end

  context 'when the command is successfully executed' do
    it 'sets the message' do
      shell_command_stub(success: true)

      step.run

      expect(step.message).to eq('Created backup of local DB.')
    end

    it 'sets the success variable' do
      shell_command_stub(success: true)

      step.run

      expect(step.success).to be true
    end
  end

  context 'when the command execution fails' do
    it 'sets the message' do
      shell_command_stub(success: false)

      step.run

      expect(step.message).to eq('Local DB backup creation failed.')
    end

    it 'does not update the success variable' do
      shell_command_stub(success: false)

      step.run

      expect(step.success).to be false
    end
  end
end
