RSpec.describe CopyBot::Steps::DropLocalDbTables do
  subject(:step) { described_class.new(step_definitions.steps[:drop_local_db_tables]) }

  let(:step_definitions) { CopyBot.step_definitions }

  before do
    step_definitions.load_step_definitions_file('spec/support/step_definitions.yml')
  end

  it 'drops tables' do
    ar_conn = active_record_conn_stub(['table1', 'table2'])

    step.run

    expect(ar_conn).to have_received(:drop_table).twice
  end

  it 'sets the message' do
    _ar_conn = active_record_conn_stub(['table1', 'table2'])

    step.run

    expect(step.message).to eq('Reset local DB schema.')
  end

  it 'sets the success variable' do
    _ar_conn = active_record_conn_stub(['table1', 'table2'])

    step.run

    expect(step.success).to be true
  end
end
