module EnvSync
  module Steps
    class RunMigrationsOnLocalDb < BaseStep
      # @return [String]
      def run
        return unless settings.run_step?(step_name.to_sym)

        Rake::Task['db:migrate'].invoke
        @message = 'Ran migrations on local DB.'
      end
    end
  end
end
