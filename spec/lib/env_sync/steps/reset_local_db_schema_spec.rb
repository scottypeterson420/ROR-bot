RSpec.describe EnvSync::Steps::ResetLocalDbSchema do
  subject(:step) { described_class.new(settings) }

  let(:settings) { EnvSync::Settings.new }

  before do
    settings.load_settings_file('spec/support/settings_with_all_steps.yml')
  end

  it 'invokes the rake tasks to purge and load the local DB schema' do
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
