# EnvSync

A gem that provides a rake task for syncing two environments: for importing a database dump into the local database,
as well as for copying files from one AWS S3 bucket to another.

This can be useful in situations when you want to sync your staging and production data so that you can debug issues
in production without having to access the production environment itself. Also, it is useful for populating
a database with production data so development and testing can be performed in circumstances that are as close to
production as possible. It is advised that the production data is anonymized beforehand.

The gem assumes that the database dump that is to be restored to the local database has already been prepared and
made available either on an AWS S3 bucket or on a local path.

## Requirements

* `aws-sdk-ruby`

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'env_sync'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install env_sync

## Application configuration

Add `config/initializers/env_sync.rb`
```ruby
EnvSync.setup do |config|
  config.logger = Rails.logger
  config.step_definitions_file_path = Rails.root.join('config/env_sync/stag_to_dev.yml')
end
```

| Option               |                   Default value                    | Description                       |
|----------------------|:--------------------------------------------------:|-----------------------------------|
| `logger`             |           Ruby's built-in Logger class             | Logging utility                   |
| `step_definitions_file_path` | n/a<br/>It is mandatory to provide a step_definitions file | Entry point for the env sync task |

### StepDefinitions file

An example of a step_definitions file implementation:

```yml
credentials:
  s3:
    access_key_id: <%= Rails.application.secrets.aws[:access_key_id] %>
    access_key: <%= Rails.application.secrets.aws[:secret_access_key] %>
    region: <%= Rails.application.secrets.aws[:region] %>
    bucket: <%= Rails.application.secrets.aws[:bucket] %>
steps:
  remote_db_dump_download:
    run: true
    source_file_path: 'attachments/staging.sql'
    destination_file_path: <%= Rails.root.join('tmp/downloaded_db_dump.sql') %>
  local_db_backup_creation:
    run: true
    destination_file_path: <%= Rails.root.join('tmp/development_backup.sql') %>
  local_db_schema_reset:
    run: true
  remote_db_dump_import:
    run: true
    remote_db_dump_file_path: <%= Rails.root.join('tmp/downloaded_db_dump.sql') %>
  migration_run_on_local_db:
    run: true
  remote_db_dump_deletion:
    run: true
  s3_bucket_sync:
    run: true
    source_bucket_name: 'production-bucket'
    source_path: 'uploads/'
    destination_bucket_name: 'staging-bucket'
    destination_path: 'uploads/'
```

Note that if you are downloading the DB dump from S3, you only need to specify the `destination_file_path` for
the `remote_db_dump_download` step - in that case you don't need the `remote_db_dump_file_path` for the `remote_db_dump_import`
step. The latter is needed only if you are not downloading the DB dump from S3 and have procured the DB dump in some
other way and saved it locally.

## Usage

To use the gem, simply run:

    $ bundle exec rake synchronize

Depending on which steps you specified should be run in the step_definitions file, this will invoke all the necessary rake tasks.

If you prefer, you can run the individual rake tasks separately:

| Rake task                                             | Description                                        |
|:------------------------------------------------------|:---------------------------------------------------|
| `bundle exec rake download_remote_db`                 | Downloads the DB dump from the specified S3 bucked |
| `bundle exec rake create_local_db_backup`             | Creates a backup of the local DB if necessary      |
| `bundle exec rake reset_local_db_schema`              | Resets the schema of the local DB                  |
| `bundle exec rake import_remote_db_to_local_db`       | Restores the remote DB dump to the local DB        |
| `bundle exec rake run_migrations_on_local_db`         | Runs migrations on the local DB                    |
| `bundle exec rake delete_remote_db_dump`              | Deletes the downloaded DB dump if necessary        |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/env_sync. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/infinum/env_sync/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EnvSync project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/env_sync/blob/master/CODE_OF_CONDUCT.md).
