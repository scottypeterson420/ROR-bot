RSpec.describe EnvSync::Steps::ExecuteCustomCommand do
  subject(:step) { described_class.new(step_settings) }

  let(:settings) { EnvSync::Settings.new }
  let(:loaded_settings) { settings.load_settings_file('spec/support/settings_with_all_steps.yml') }
  let(:step_settings) { loaded_settings.dig(:steps, :execute_custom_command) }

  context 'when the custom command is not provided' do
    before { loaded_settings[:steps][:execute_custom_command].delete(:command) }

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
