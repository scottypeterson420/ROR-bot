RSpec.describe EnvSync::Config do
  context 'without custom options' do
    let(:config) { described_class.new }

    it 'initializes the default logger' do
      expect(config.logger).to be_an_instance_of(Logger)
    end
  end
end
