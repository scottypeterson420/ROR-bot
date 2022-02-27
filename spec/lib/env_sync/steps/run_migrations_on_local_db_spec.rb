RSpec.describe EnvSync::Steps::RunMigrationsOnLocalDb do
  subject(:step) { described_class.new(settings) }

  let(:settings) { EnvSync::Settings.new }

  before do
    settings.load_settings_file('spec/support/settings_with_all_steps.yml')
  end

  it 'does not invoke the rake task to run migrations on the the local DB if the step should not be run' do
    settings.steps.delete(:run_migrations_on_local_db)
    task = migrate_task_stub

    step.run

    expect(task).not_to have_received(:invoke)
  end

  context 'when the step should be run' do
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
  end
end
