module EnvSync
  module Steps
    class CreateLocalDbBackup < BaseStep
      # @return [String]
      def run
        return unless settings.run_step?(step_name.to_sym)

        @success = EnvSync::Command.new(command).execute
        @message = @success ? 'Created backup of local DB.' : 'Local DB backup creation failed.'
      end

      private

      # @return [String]
      def command
        "pg_dump -U #{db_conn_config[:username]} -h #{db_conn_config[:host]} -p #{db_conn_config[:port]} " \
          "#{db_conn_config[:database]} > #{destination_file_path}"
      end

      # @return [ActiveRecord::DatabaseConfigurations::HashConfig]
      def db_conn_config
        ActiveRecord::Base.connection_db_config
      end

      # @return [Hash]
      def destination_file_path
        step_settings[:destination_file_path]
      end
    end
  end
end
