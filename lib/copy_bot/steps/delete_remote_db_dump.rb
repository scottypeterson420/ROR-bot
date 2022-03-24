module CopyBot
  module Steps
    class DeleteRemoteDbDump < BaseStep
      # @return [String]
      def run
        return @message = 'Missing remote DB dump file' unless remote_db_dump_file_valid?

        File.delete(remote_db_dump_file_path)
        @success = true
        @message = "Deleted file #{remote_db_dump_file_path}"
      end

      private

      def remote_db_dump_file_valid?
        remote_db_dump_file_path && File.exist?(remote_db_dump_file_path)
      end

      def remote_db_dump_file_path
        step_definition[:remote_db_dump_file_path]
      end
    end
  end
end
