RSpec.describe CopyBot do
  let(:step_definitions) { described_class.step_definitions }
  let!(:s3_object) { s3_object_stub }
  let!(:command) { command_stub(success: true) }
  let!(:ar_conn) { active_record_conn_stub(['table1', 'table2']) }
  let!(:migrate_task) { migrate_task_stub }

  before do
    db_conn_config_stub
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:delete)

    step_definitions.load_step_definitions_file('spec/support/step_definitions.yml')

    described_class.step_definitions.steps.each_key do |step_name|
      CopyBot::StepRunner.new(step_name).call
    end
  end

  it 'downloads the S3 object' do
    expect(s3_object).to have_received(:download_file)
  end

  it 'runs the command to create the local DB backup, import the remote DB and the custom command' do
    expect(command).to have_received(:execute).exactly(3).times
  end

  it 'drops the local DB tables' do
    expect(ar_conn).to have_received(:drop_table).twice
  end

  it 'runs migrations on the local DB' do
    expect(migrate_task).to have_received(:invoke).once
  end

  it 'deletes the remote DB dump file' do
    expect(File).to have_received(:delete)
  end
end
