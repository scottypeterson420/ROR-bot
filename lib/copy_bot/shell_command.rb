module CopyBot
  class ShellCommand
    # @param [String] command
    def initialize(command)
      @command = command
    end

    # @return [FalseClass, TrueClass]
    def execute
      stdout, stderr, status = Open3.capture3(command)
      return true if status.exitstatus&.zero?

      CopyBot.config.logger.debug { "#{stdout}, #{stderr}" }
      false
    end

    private

    attr_reader :command
  end
end
