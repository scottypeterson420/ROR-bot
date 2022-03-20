module EnvSync
  module Steps
    class BaseStep
      attr_reader :message
      attr_reader :success

      def initialize(step_settings)
        @step_settings = step_settings
        @message = nil
        @success = false
      end

      # @raise [NotImplementedError]
      def run
        raise NotImplementedError
      end

      private

      attr_reader :step_settings

      def step_name
        self.class.name.demodulize.underscore
      end
    end
  end
end
