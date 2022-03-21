require 'active_record'
require 'aws-sdk-s3'
require 'erb'
require 'logger'
require 'open3'
require 'rake'
require 'rails'
require 'yaml'

require 'env_sync/version'
require 'env_sync/command'
require 'env_sync/config'
require 'env_sync/railtie' if defined?(Rails::Railtie)
require 'env_sync/step_definitions'
require 'env_sync/step_factory'
require 'env_sync/steps/base_step'
require 'env_sync/steps/create_local_db_backup'
require 'env_sync/steps/delete_remote_db_dump'
require 'env_sync/steps/download_remote_db_dump'
require 'env_sync/steps/execute_custom_command'
require 'env_sync/steps/import_remote_db_to_local_db'
require 'env_sync/steps/reset_local_db_schema'
require 'env_sync/steps/run_migrations_on_local_db'

module EnvSync
  # @yield [EnvSync::Config]
  def self.setup
    yield config
  end

  # @return [EnvSync::Config]
  def self.config
    @config ||= Config.new
  end

  # @return [EnvSync::StepDefinitions]
  def self.step_definitions
    @step_definitions ||= StepDefinitions.new
  end
end
