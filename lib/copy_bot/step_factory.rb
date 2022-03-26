module CopyBot
  class StepFactory
    attr_reader :step_name

    # @param [Symbol] step_name
    def initialize(step_name)
      @step_name = step_name
    end

    # @return [Class<CopyBot::Steps::BaseStep>]
    def build # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
      case step_name
      when :download_remote_db_dump
        ::CopyBot::Steps::DownloadRemoteDbDump
      when :create_local_db_backup
        ::CopyBot::Steps::CreateLocalDbBackup
      when :drop_local_db_tables
        ::CopyBot::Steps::DropLocalDbTables
      when :import_remote_db_to_local_db
        ::CopyBot::Steps::ImportRemoteDbToLocalDb
      when :run_migrations_on_local_db
        ::CopyBot::Steps::RunMigrationsOnLocalDb
      when :delete_remote_db_dump
        ::CopyBot::Steps::DeleteRemoteDbDump
      when :execute_custom_command
        ::CopyBot::Steps::ExecuteCustomCommand
      else
        raise ArgumentError
      end
    end
  end
end
