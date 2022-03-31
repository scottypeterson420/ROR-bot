module CopyBot
  module Steps
    class DropLocalDbTables < BaseStep
      # @return [String]
      def run
        conn = ActiveRecord::Base.connection
        conn.tables.each do |table|
          CopyBot.config.logger.info("Dropping #{table}")
          conn.drop_table(table, force: :cascade, if_exists: true)
        end

        @success = true
        @message = 'Reset local DB schema.'
      end
    end
  end
end
