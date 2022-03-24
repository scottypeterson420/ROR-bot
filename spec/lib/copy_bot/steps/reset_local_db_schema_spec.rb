RSpec.describe CopyBot::Steps::ResetLocalDbSchema do
  subject(:step) { described_class.new(step_definitions) }

  let(:step_definitions) { CopyBot::StepDefinitions.new }

  before do
    step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')
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

  it 'sets the success variable' do
    _task = schema_load_task_stub

    step.run

    expect(step.success).to be true
  end
end
