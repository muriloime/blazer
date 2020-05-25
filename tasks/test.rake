desc 'Run the full suite using parallel_tests to run on multiple cores'
task test: %i[setup spec]

desc "Create a test rails app for the parallel specs to run against if it doesn't exist already"
task setup: :"setup:create"

namespace :setup do
  desc 'Forcefully create a test rails app for the parallel specs to run against'
  task :force, %i[rails_env template] => %i[require rm run]

  desc "Create a test rails app for the parallel specs to run against if it doesn't exist already"
  task :create, %i[rails_env template] => %i[require run]

  desc 'Makes test app creation code available'
  task :require do
    if ENV['COVERAGE'] == 'true'
      require 'simplecov'

      SimpleCov.command_name 'test app creation'
    end

    require_relative 'test_application'
  end

  desc 'Create a test rails app for the parallel specs to run against'
  task :run, [:rails_env, :template] do |_t, opts|
    Blazer::TestApplication.new(opts).soft_generate
  end

  task :rm, [:rails_env, :template] do |_t, opts|
    test_app = Blazer::TestApplication.new(opts)

    FileUtils.rm_rf test_app.app_dir
  end
end

task spec: :"spec:all"

namespace :spec do
  desc 'Run all specs'
  task all: [:regular] # :filesystem_changes

  desc 'Run the standard specs'
  task :regular do
    sh('bin/rspec spec/')
  end

  # desc "Run the specs that change the filesystem sequentially"
  # task :filesystem_changes do
  #   sh({ "RSPEC_FILESYSTEM_CHANGES" => "true" }, "bin/rspec")
  # end
end
