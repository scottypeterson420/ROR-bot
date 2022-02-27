RSpec.describe EnvSync::Steps::ResetLocalDbSchema do
  subject(:step) { described_class.new(settings) }

  let(:settings) { EnvSync::Settings.new }

  before do
    settings.load_settings_file('spec/support/settings_with_all_steps.yml')
  end

  it 'does not invoke the rake task to reset the local DB schema if the step should not be run' do
    settings.steps.delete(:reset_local_db_schema)
    task = schema_load_task_stub

    step.run

    expect(task).not_to have_received(:invoke)
  end

  context 'when the step should be run' do
    it 'invokes the rake task to reset the local DB schema' do
      task = schema_load_task_stub

      step.run

      expect(task).to have_received(:invoke).once
    end

    it 'sets the message' do
      _task = schema_load_task_stub

      step.run

      expect(step.message).to eq('Reset local DB schema.')
    end
  end
end
