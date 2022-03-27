module CopyBot
  class StepRunner
    # @param [String] step_name
    def initialize(step_name)
      @step_name = step_name.to_sym
    end

    # @return [FalseClass, TrueClass]
    def call # rubocop:disable Metrics/AbcSize
      logger.info("Started step: #{step_name}")

      step.run

      step.success ? logger.info(step.message) : logger.debug(step.message)
      step.success
    end

    private

    attr_reader :step_name

    def logger
      CopyBot.config.logger
    end

    def step
      @step ||= step_class.new(step_definition)
    end

    def step_definition
      CopyBot.step_definitions.steps[step_name]
    end

    def step_class
      CopyBot::StepFactory.new(step_name).build
    end
  end
end
