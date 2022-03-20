module EnvSync
  class Settings
    attr_reader :loaded_settings

    def initialize
      @loaded_settings = {}
    end

    # @param [String] settings_file_path
    # @return [Hash]
    def load_settings_file(settings_file_path)
      @loaded_settings = YAML.safe_load(ERB.new(File.read(settings_file_path)).result).deep_symbolize_keys
    end

    # @return [Hash]
    def steps
      loaded_settings[:steps]
    end
  end
end
