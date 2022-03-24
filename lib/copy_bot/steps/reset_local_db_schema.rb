module CopyBot
  module Steps
    class ResetLocalDbSchema < BaseStep
      # @return [String]
      def run
        # conn = ActiveRecord::Base.connection
        # tables = conn.tables
        # tables.each do |table|
        #   CopyBot.config.logger.info("Dropping #{table}")
        #   conn.drop_table(table, force: :cascade)
        # end
        #
        # # Rake::Task['db:schema:load'].invoke
        # @message = 'Reset local DB schema.'
        # @success = true
      end
    end
  end
end
