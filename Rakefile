#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Canary::Application.load_tasks

namespace :ci do

  # Command for running the specs
  task :spec do
    system("bundle exec rspec spec/")
  end

  # Running the entire rake task
  desc "Prepare for CI and run entire test suite"
    task :build => ['db:create', 'db:migrate', 'ci:spec'] do
  end
  
end
