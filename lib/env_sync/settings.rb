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

    # @param [Symbol] step_key
    # @return [FalseClass, TrueClass]
    def run_step?(step_key)
      steps.key?(step_key)
    end

    # @return [String]
    def remote_db_dump_file_path
      remote_db_dump_file_path = steps.dig(:import_remote_db_to_local_db, :remote_db_dump_file_path)
      return remote_db_dump_file_path if remote_db_dump_file_path

      steps.dig(:download_remote_db_dump, :destination_file_path)
    end
  end
end
