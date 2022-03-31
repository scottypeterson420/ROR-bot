module CopyBot
  module Steps
    class CreateLocalDbBackup < BaseStep
      # @return [String]
      def run
        @success = CopyBot::ShellCommand.new(command).execute
        @message = @success ? 'Created backup of local DB.' : 'Local DB backup creation failed.'
      end

      private

      def command
        "pg_dump -U #{db_conn_config[:username]} -h #{db_conn_config[:host]} -p #{db_conn_config[:port]} " \
          "#{db_conn_config[:database]} > #{destination_file_path}"
      end

      def db_conn_config
        ActiveRecord::Base.connection_db_config.configuration_hash
      end

      def destination_file_path
        step_definition[:destination_file_path]
      end
    end
  end
end
