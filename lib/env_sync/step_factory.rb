module EnvSync
  class StepFactory
    attr_reader :step_name

    def initialize(step_name)
      @step_name = step_name
    end

    # @return [Class<EnvSync::Steps::ExecuteCustomCommand>,
    #          Class<EnvSync::Steps::DeleteRemoteDbDump>,
    #          Class<EnvSync::Steps::RunMigrationsOnLocalDb>,
    #          Class<EnvSync::Steps::ImportRemoteDbToLocalDb>,
    #          Class<EnvSync::Steps::ResetLocalDbSchema>,
    #          Class<EnvSync::Steps::CreateLocalDbBackup>,
    #          Class<EnvSync::Steps::DownloadRemoteDbDump>]
    def build # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
      case step_name
      when 'download_remote_db_dump'
        ::EnvSync::Steps::DownloadRemoteDbDump
      when 'create_local_db_backup'
        ::EnvSync::Steps::CreateLocalDbBackup
      when 'reset_local_db_schema'
        ::EnvSync::Steps::ResetLocalDbSchema
      when 'import_remote_db_to_local_db'
        ::EnvSync::Steps::ImportRemoteDbToLocalDb
      when 'run_migrations_on_local_db'
        ::EnvSync::Steps::RunMigrationsOnLocalDb
      when 'delete_remote_db_dump'
        ::EnvSync::Steps::DeleteRemoteDbDump
      when 'execute_custom_command'
        ::EnvSync::Steps::ExecuteCustomCommand
      else
        raise ArgumentError
      end
    end
  end
end
