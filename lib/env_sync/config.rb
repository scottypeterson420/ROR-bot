module EnvSync
  class Config
    # @return [Logger]
    attr_accessor :logger

    def initialize
      @logger = default_logger
    end

    private

    # @return [Logger]
    def default_logger
      Logger.new($stdout).tap do |log|
        log.progname = self.class.name.split('::').first
      end
    end
  end
end
