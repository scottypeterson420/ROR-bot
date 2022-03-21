module EnvSync
  class Command
    # @param [String] command_string
    def initialize(command_string)
      @command_string = command_string
    end

    # @return [FalseClass, TrueClass]
    def execute
      stdout, stderr, status = Open3.capture3(command_string)
      return true if status.exitstatus&.zero?

      EnvSync.config.logger.debug { "#{stdout}, #{stderr}" }
      false
    end

    private

    attr_reader :command_string
  end
end
