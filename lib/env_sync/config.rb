module EnvSync
  class Config
    # @return [Logger]
    attr_accessor :logger
    # @return [Array<String>]
    attr_accessor :permitted_environments

    DEFAULT_PERMITTED_ENVIRONMENTS = ['development'].freeze

    def initialize
      @logger = default_logger
      @permitted_environments = DEFAULT_PERMITTED_ENVIRONMENTS
    end

    private

    def default_logger
      Logger.new($stdout).tap do |log|
        log.progname = self.class.name.split('::').first
      end
    end
  end
end
