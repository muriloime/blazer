require 'bundler/gem_tasks'

import 'tasks/gemfiles.rake'
# import 'tasks/local.rake'
import 'tasks/test.rake'

gemfile = ENV['BUNDLE_GEMFILE']

task default: :test

task :console do
  require 'irb'
  require 'irb/completion'

  ARGV.clear
  IRB.start
end