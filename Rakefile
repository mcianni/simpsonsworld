require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require './lib/simpsons_world'

desc "Scrape data from simpsonsworld.com"
task :scrape do
  SimpsonsWorld::Scrape.all
end

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'documentation']
end

#task :default => :spec
