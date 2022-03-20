module EnvSync
  module Steps
    class ExecuteCustomCommand < BaseStep
      require 'pry'
      # @return [String]
      def run
        return unless custom_command

        @success = EnvSync::Command.new(custom_command).execute
        @message = success ? 'Custom command executed.' : 'Custom command failed.'
      end

      private

      def custom_command
        return unless step_settings

        step_settings[:command]
      end
    end
  end
end
