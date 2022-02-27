RSpec.describe EnvSync::StepFactory do
  describe '#build' do
    it 'returns ::EnvSync::Steps::DownloadRemoteDbDump if step name is download_remote_db_dump' do
      expect(described_class.new('download_remote_db_dump').build)
        .to eq(::EnvSync::Steps::DownloadRemoteDbDump)
    end

    it 'returns ::EnvSync::Steps::CreateLocalDbBackup if step name is create_local_db_backup' do
      expect(described_class.new('create_local_db_backup').build)
        .to eq(::EnvSync::Steps::CreateLocalDbBackup)
    end

    it 'returns ::EnvSync::Steps::ResetLocalDbSchema if step name is reset_local_db_schema' do
      expect(described_class.new('reset_local_db_schema').build).to eq(::EnvSync::Steps::ResetLocalDbSchema)
    end

    it 'returns ::EnvSync::Steps::ImportRemoteDbToLocalDb if step name is import_remote_db_to_local_db' do
      expect(described_class.new('import_remote_db_to_local_db').build)
        .to eq(::EnvSync::Steps::ImportRemoteDbToLocalDb)
    end

    it 'returns ::EnvSync::Steps::RunMigrationsOnLocalDb if step name is run_migrations_on_local_db' do
      expect(described_class.new('run_migrations_on_local_db').build)
        .to eq(::EnvSync::Steps::RunMigrationsOnLocalDb)
    end

    it 'returns ::EnvSync::Steps::DeleteRemoteDbDump if step name is delete_remote_db_dump' do
      expect(described_class.new('delete_remote_db_dump').build).to eq(::EnvSync::Steps::DeleteRemoteDbDump)
    end

    it 'returns ::EnvSync::Steps::ExecuteCustomCommand if step name is execute_custom_command' do
      expect(described_class.new('execute_custom_command').build)
        .to eq(::EnvSync::Steps::ExecuteCustomCommand)
    end

    it 'raises ArgumentError when step name does not match any of the cases' do
      expect { described_class.new('some_step_name').build }.to raise_error(ArgumentError)
    end
  end
end
