module EnvSync
  module Steps
    class ExecuteCustomCommand < BaseStep
      # @return [String]
      def run
        return @message = 'Custom command missing' unless custom_command

        @success = EnvSync::Command.new(custom_command).execute
        @message = @success ? 'Custom command executed.' : 'Custom command failed.'
      end

      private

      def custom_command
        return unless step_definition

        step_definition[:command]
      end
    end
  end
end
