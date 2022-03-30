require_relative 'lib/copy_bot/version'

Gem::Specification.new do |spec|
  spec.name = 'copy_bot'
  spec.version = CopyBot::VERSION
  spec.authors = ['Rails Team']
  spec.email = ['team.rails@infinum.com']

  spec.summary = 'Tool for syncing the data sync between two environments.'
  spec.description = 'Provides a rake task for importing a database dump into a database on a particular environment.'
  spec.homepage = 'https://github.com/infinum/copy_bot'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.1')

  # TODO: spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'aws-sdk-s3'
  spec.add_dependency 'rails', '>= 6.1'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-infinum'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
