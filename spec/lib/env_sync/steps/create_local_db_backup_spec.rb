RSpec.describe EnvSync::Steps::CreateLocalDbBackup do
  subject(:step) { described_class.new(step_definition) }

  let(:step_definitions) { EnvSync::StepDefinitions.new }
  let(:loaded_step_definitions) do
    step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')
  end
  let(:step_definition) { loaded_step_definitions.dig(:steps, :execute_custom_command) }

  before { db_conn_config_stub }

  it 'executes the command' do
    command = successful_command_stub

    step.run

    expect(command).to have_received(:execute)
  end

  context 'when the command is successfully executed' do
    it 'sets the message' do
      successful_command_stub

      step.run

      expect(step.message).to eq('Created backup of local DB.')
    end

    it 'sets the success variable' do
      successful_command_stub

      step.run

      expect(step.success).to be true
    end
  end

  context 'when the command execution fails' do
    it 'sets the message' do
      failed_successful_command_stub

      step.run

      expect(step.message).to eq('Local DB backup creation failed.')
    end

    it 'does not update the success variable' do
      failed_successful_command_stub

      step.run

      expect(step.success).to be false
    end
  end
end
