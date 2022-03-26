RSpec.describe CopyBot::Steps::ExecuteCustomCommand do
  subject(:step) { described_class.new(step_definitions.steps[:execute_custom_command]) }

  let(:step_definitions) { CopyBot.step_definitions }

  before do
    step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')
  end

  context 'when the custom command is not provided' do
    before { step_definitions.steps[:execute_custom_command].delete(:command) }

    it 'does not execute the command' do
      command = successful_command_stub

      step.run

      expect(command).not_to have_received(:execute)
    end

    it 'sets the message' do
      step.run

      expect(step.message).to eq('Custom command missing')
    end
  end

  it 'executes the command' do
    command = successful_command_stub

    step.run

    expect(command).to have_received(:execute)
  end

  context 'when the command is successfully executed' do
    it 'sets the message' do
      successful_command_stub

      step.run

      expect(step.message).to eq('Custom command executed.')
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

      expect(step.message).to eq('Custom command failed.')
    end

    it 'does not update the success variable' do
      failed_successful_command_stub

      step.run

      expect(step.success).to be false
    end
  end
end
