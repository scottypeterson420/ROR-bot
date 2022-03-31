module CopyBot
  module Steps
    class ImportRemoteDbToLocalDb < BaseStep
      # @return [String]
      def run
        return @message = 'Missing remote DB dump file' unless source_file_valid?

        @success = CopyBot::ShellCommand.new(command).execute
        @message = @success ? 'Imported remote DB to local DB.' : 'Remote DB to local DB import failed.'
      end

      private

      def source_file_valid?
        source_file_path && File.exist?(source_file_path)
      end

      def source_file_path
        step_definition[:remote_db_dump_file_path]
      end

      def command
        "psql -U #{db_conn_config[:username]} -h #{db_conn_config[:host]} -p #{db_conn_config[:port]} " \
          "#{db_conn_config[:database]} < #{source_file_path}"
      end

      def db_conn_config
        ActiveRecord::Base.connection_db_config.configuration_hash
      end
    end
  end
end
