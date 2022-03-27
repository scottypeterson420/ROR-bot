RSpec.describe CopyBot::StepFactory do
  describe '#build' do
    it 'returns ::CopyBot::Steps::DownloadRemoteDbDump if step name is download_remote_db_dump' do
      expect(described_class.new(:download_remote_db_dump).build)
        .to eq(::CopyBot::Steps::DownloadRemoteDbDump)
    end

    it 'returns ::CopyBot::Steps::CreateLocalDbBackup if step name is create_local_db_backup' do
      expect(described_class.new(:create_local_db_backup).build)
        .to eq(::CopyBot::Steps::CreateLocalDbBackup)
    end

    it 'returns ::CopyBot::Steps::ResetLocalDbSchema if step name is drop_loadl_db_tables' do
      expect(described_class.new(:drop_local_db_tables).build).to eq(::CopyBot::Steps::DropLocalDbTables)
    end

    it 'returns ::CopyBot::Steps::ImportRemoteDbToLocalDb if step name is import_remote_db_to_local_db' do
      expect(described_class.new(:import_remote_db_to_local_db).build)
        .to eq(::CopyBot::Steps::ImportRemoteDbToLocalDb)
    end

    it 'returns ::CopyBot::Steps::RunMigrationsOnLocalDb if step name is run_migrations_on_local_db' do
      expect(described_class.new(:run_migrations_on_local_db).build)
        .to eq(::CopyBot::Steps::RunMigrationsOnLocalDb)
    end

    it 'returns ::CopyBot::Steps::DeleteRemoteDbDump if step name is delete_remote_db_dump' do
      expect(described_class.new(:delete_remote_db_dump).build).to eq(::CopyBot::Steps::DeleteRemoteDbDump)
    end

    it 'returns ::CopyBot::Steps::ExecuteCustomCommand if step name is execute_custom_command' do
      expect(described_class.new(:execute_custom_command).build)
        .to eq(::CopyBot::Steps::ExecuteCustomCommand)
    end

    it 'raises ArgumentError when step name does not match any of the cases' do
      expect { described_class.new(:some_step_name).build }.to raise_error(ArgumentError)
    end
  end
end
