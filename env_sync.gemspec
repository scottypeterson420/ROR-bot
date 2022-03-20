require_relative 'lib/env_sync/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name = 'env_sync'
  spec.version = EnvSync::VERSION
  spec.authors = ['Rails Team']
  spec.email = ['team.rails@infinum.com']

  spec.summary = 'Tool syncing the database with another environment.'
  spec.description = 'Provides a rake task for importing a database dump into a database on a particular environment,
                      as well as for syncing AWS S3 buckets if necessary.'
  spec.homepage = 'https://github.com/infinum/env_sync'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.1'

  # TODO: spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'aws-sdk-s3'

  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-infinum'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
