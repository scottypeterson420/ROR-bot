module EnvSync
  module Steps
    class RunMigrationsOnLocalDb < BaseStep
      # @return [String]
      def run
        Rake::Task['db:migrate'].invoke
        @message = 'Ran migrations on local DB.'
      end
    end
  end
end
