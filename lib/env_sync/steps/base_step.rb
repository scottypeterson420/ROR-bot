module EnvSync
  module Steps
    class BaseStep
      attr_reader :message
      attr_reader :success

      def initialize(settings)
        @settings = settings
        @message = nil
        @success = false
      end

      # @raise [NotImplementedError]
      def run
        raise NotImplementedError
      end

      private

      attr_reader :settings

      def step_name
        self.class.name.demodulize.underscore
      end

      def step_settings
        settings.steps[step_name.to_sym]
      end
    end
  end
end
