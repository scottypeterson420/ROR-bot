RSpec.describe CopyBot::Config do
  context 'without custom options' do
    let(:config) { described_class.new }

    it 'initializes the default logger' do
      expect(config.logger).to be_an_instance_of(Logger)
    end

    it 'initializes default permitted environments' do
      expect(config.permitted_environments).to match_array(['development'])
    end
  end
end
