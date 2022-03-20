module EnvSync
  module Steps
    class ResetLocalDbSchema < BaseStep
      # @return [String]
      def run
        Rake::Task['db:purge'].invoke
        Rake::Task['db:schema:load'].invoke
        @message = 'Reset local DB schema.'
      end
    end
  end
end
