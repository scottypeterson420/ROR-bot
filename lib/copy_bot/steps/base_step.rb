module CopyBot
  module Steps
    class BaseStep
      # @param [String]
      attr_reader :message

      # @return [FalseClass, TrueClass]
      attr_reader :success

      # @param [Hash] step_definition
      def initialize(step_definition)
        @step_definition = step_definition
        @message = nil
        @success = false
      end

      # @raise [NotImplementedError]
      def run
        raise NotImplementedError
      end

      private

      attr_reader :step_definition

      def step_name
        self.class.name.demodulize.underscore
      end
    end
  end
end
