module EnvSync
  module Steps
    class ResetLocalDbSchema < BaseStep
      # @return [String]
      def run
        Rake::Task['db:schema:load'].invoke
        @message = 'Reset local DB schema.'
        @success = true
      end
    end
  end
end
