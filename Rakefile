# rubocop:disable all

require 'bundler/gem_tasks'

exec = []

begin
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new

  exec << :rubocop
rescue LoadError
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) { |t| t.rspec_opts = %w{--tag ~slow} }

  exec << :spec
rescue LoadError
end

# Run rubocop & rspec before the build (only if installed)
task build: exec

# rubocop:enable all
