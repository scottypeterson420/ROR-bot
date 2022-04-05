# CopyBot

A gem that provides a rake task for importing a database dump into the local database,
as well as for running any additional scripts afterwards.

This can be useful in situations when you want to sync your staging and production data so that you can debug issues
in production without having to access the production environment itself. Also, it is useful for populating
a database with production data so development and testing can be performed in circumstances that are as close to
production as possible. It is advised that the production data is anonymized beforehand.

The gem assumes that the database dump that is to be restored to the local database has already been prepared and
made available either on an AWS S3 bucket or on a local path.

## Requirements

* `aws-sdk-ruby`
* `rails`

## Supported databases

* PostgreSQL

## Installation

Add this line to your application's Gemfile:

```ruby

gem 'copy_bot'

```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install copy_bot

## Application configuration

Add `config/initializers/copy_bot.rb`

```ruby

CopyBot.setup do |config|
  config.logger = Rails.logger
  config.permitted_environments = ['development', 'staging']
end

```
| Option                   |        Default value         | Description                                                                                              |
|--------------------------|:----------------------------:|----------------------------------------------------------------------------------------------------------|
| `logger`                 | Ruby's built-in Logger class | Logging utility that by default outputs to $stdout                                                       |
| `permitted_environments` |      `['development']`       | Array with environments where the rake task is allowed to be run (since it contains destructive actions) |

### Step definitions file

It is necessary to define steps that should be run in a .yml file:

```yml
steps:
  download_remote_db_dump:
    s3_credentials:
      access_key_id: <%= Rails.application.secrets.aws_access_key_id %>
      access_key: <%= Rails.application.secrets.aws_secret_access_key %>
      region: <%= Rails.application.secrets.aws_region %>
      bucket: <%= Rails.application.secrets.aws_s3_bucket %>
    source_file_path: '/staging_db_dump.sql'
    destination_file_path: './tmp/downloaded_db_dump.sql'
  create_local_db_backup:
    destination_file_path: './tmp/development_backup.sql'
  drop_local_db_tables:
  import_remote_db_to_local_db:
    remote_db_dump_file_path: './tmp/downloaded_db_dump.sql'
  run_migrations_on_local_db:
  delete_remote_db_dump:
    remote_db_dump_file_path: './tmp/downloaded_db_dump.sql'
  execute_custom_command:
    command: 'RAILS_ENV=staging bundle exec rake some_task'
```

The example above contains all possible steps in the exact order in which they are run.
Not all steps are mandatory.
If a certain step doesn't need to be run, just omit it from the steps definition file. For example, you may not want
to download the database dump from an S3 bucket, but you have acquired it in some other way and you have it available
locally. In that case, omit the `download_remote_db_dump` step and add the relevant `remote_db_dump_file_path` to the
`import_remote_db_to_local_db` step.

**IMPORTANT:** 
These steps include some destructive actions, e.g. `drop_local_db_tables` will drop all tables in the local database
so make sure you don't use this gem in an environment where you do not want to lose data.

## Usage

To use the gem, simply run:

    $ bundle exec rake copy_bot STEP_DEFINITIONS_FILE_PATH=config/copy_bot/step_definitions.yml

Please note that the step definitions file is passed to the rake task as an environment variable, not an argument.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update
the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for
the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/copy_bot. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected to adhere to
the [code of conduct](https://github.com/infinum/copy_bot/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CopyBot project's codebases, issue trackers, chat rooms and mailing lists is expected
to follow the [code of conduct](https://github.com/infinum/copy_bot/blob/master/CODE_OF_CONDUCT.md).
