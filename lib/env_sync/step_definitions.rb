module EnvSync
  class StepDefinitions
    # @return [Hash]
    attr_reader :loaded_step_definitions

    def initialize
      @loaded_step_definitions = {}
    end

    # @param [String] step_definitions_file_path
    # @return [Hash]
    def load_step_definitions_file(step_definitions_file_path)
      @loaded_step_definitions = YAML.safe_load(ERB.new(File.read(step_definitions_file_path)).result)
                                     .deep_symbolize_keys
    end

    # @return [Hash]
    def steps
      loaded_step_definitions[:steps]
    end
  end
end
