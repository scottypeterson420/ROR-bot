module EnvSync
  module Steps
    class ResetLocalDbSchema < BaseStep
      # @return [String]
      def run
        return unless settings.run_step?(step_name.to_sym)

        Rake::Task['db:schema:load'].invoke
        @message = 'Reset local DB schema.'
      end
    end
  end
end
