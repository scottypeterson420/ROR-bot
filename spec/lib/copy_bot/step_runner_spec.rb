RSpec.describe CopyBot::StepRunner do
  require 'pry'
  describe '#call' do
    subject(:step_runner) { described_class.new('create_local_db_backup') }

    let(:step_definitions) { CopyBot.step_definitions }
    let(:logger) { CopyBot.config.logger }

    before do
      step_definitions.load_step_definitions_file('spec/support/step_definitions_with_all_steps.yml')
      allow(logger).to receive(:info)
      allow(logger).to receive(:debug)
    end

    context 'when the step was run successfully' do
      before { create_local_db_backup_step_stub(true) }

      it 'returns true' do
        expect(step_runner.call).to be true
      end

      it 'logs the step message' do
        step_runner.call

        expect(logger).to have_received(:info).twice
      end
    end

    context 'when the step failed' do
      before { create_local_db_backup_step_stub(false) }

      it 'returns false if the step failed' do
        expect(step_runner.call).to be false
      end

      it 'logs the step message' do
        step_runner.call

        expect(logger).to have_received(:info).once
        expect(logger).to have_received(:debug).once
      end
    end
  end
end
