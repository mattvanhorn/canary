namespace :cover_me do
  
  desc "Generates and opens code coverage report."
  task :report do
    require 'cover_me'
    CoverMe.config do |c|
      # files you want to explicitly exclude from coverage
      c.exclude_file_patterns = ['lib/test_support/black_hole_store.rb']
    end
    CoverMe.complete!
  end
  
end

task :test do
  Rake::Task['cover_me:report'].invoke
end

task :spec do
  Rake::Task['cover_me:report'].invoke
end