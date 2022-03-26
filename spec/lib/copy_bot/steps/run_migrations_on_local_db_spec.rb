RSpec.describe CopyBot::Steps::RunMigrationsOnLocalDb do
  subject(:step) { described_class.new(step_definitions.steps[:run_migrations_on_local_db]) }

  let(:step_definitions) { CopyBot.step_definitions }

  before do
    step_definitions.load_step_definitions_file('spec/support/step_definitions.yml')
  end

  it 'invokes the rake task to run migrations on the local DB' do
    task = migrate_task_stub

    step.run

    expect(task).to have_received(:invoke).once
  end

  it 'sets the message' do
    _task = migrate_task_stub

    step.run

    expect(step.message).to eq('Ran migrations on local DB.')
  end

  it 'sets the success variable' do
    _task = migrate_task_stub

    step.run

    expect(step.success).to be true
  end
end
