require 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require_relative "../tasks/test_application"

puts Blazer::TestApplication.new.full_app_dir
require "#{Blazer::TestApplication.new.full_app_dir}/config/environment.rb"

require "active_record/railtie"
require "action_controller/railtie"

require 'rspec/rails'

require 'factory_bot_rails'

FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), 'factories')

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures = false
  config.render_views = false
end

# Force deprecations to raise an exception.
ActiveSupport::Deprecation.behavior = :raise