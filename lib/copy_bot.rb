require 'active_record'
require 'aws-sdk-s3'
require 'erb'
require 'logger'
require 'open3'
require 'rake'
require 'rails'
require 'yaml'

require 'copy_bot/version'
require 'copy_bot/command'
require 'copy_bot/config'
require 'copy_bot/railtie' if defined?(Rails::Railtie)
require 'copy_bot/step_definitions'
require 'copy_bot/step_factory'
require 'copy_bot/steps/base_step'
require 'copy_bot/steps/create_local_db_backup'
require 'copy_bot/steps/delete_remote_db_dump'
require 'copy_bot/steps/download_remote_db_dump'
require 'copy_bot/steps/execute_custom_command'
require 'copy_bot/steps/import_remote_db_to_local_db'
require 'copy_bot/steps/reset_local_db_schema'
require 'copy_bot/steps/run_migrations_on_local_db'

module CopyBot
  # @yield [CopyBot::Config]
  def self.setup
    yield config
  end

  # @return [CopyBot::Config]
  def self.config
    @config ||= Config.new
  end

  # @return [CopyBot::StepDefinitions]
  def self.step_definitions
    @step_definitions ||= StepDefinitions.new
  end
end
