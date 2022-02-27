module EnvSync
  module Steps
    class ExecuteCustomCommand < BaseStep
      def run
        return unless settings.run_step?(step_name.to_sym)
        return unless custom_command

        @success = EnvSync::Command.new(custom_command).execute
        @message = success ? 'Custom command executed.' : 'Custom command failed.'
      end

      private

      def custom_command
        step_settings[:command]
      end
    end
  end
end
