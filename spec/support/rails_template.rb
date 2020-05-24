# Rails template to build the sample app for specs

# webpacker_app = ENV["BUNDLE_GEMFILE"] == File.expand_path("../../gemfiles/rails_60_webpacker/Gemfile", __dir__)
webpacker_app = true 

if webpacker_app
  create_file 'app/javascript/packs/some-random-css.css'
  create_file 'app/javascript/packs/some-random-js.js'
else
  create_file 'app/assets/stylesheets/some-random-css.css'
  create_file 'app/assets/javascripts/some-random-js.js'
end

create_file 'app/assets/images/a/favicon.ico'

timestamps = 'created_at:datetime updated_at:datetime'

generate :migration, 'create_posts title:string body:text published_date:date author_id:integer ' +
  "position:integer custom_category_id:integer starred:boolean foo_id:integer #{timestamps}"

# copy_file File.expand_path('templates/models/user.rb', __dir__), 'app/models/user.rb'

generate :migration, "create_users type:string first_name:string last_name:string username:string age:integer encrypted_password:string #{timestamps}"

generate :model, 'store name:string user_id:integer'

gsub_file 'config/environments/test.rb', /  config.cache_classes = true/, <<-RUBY
  config.cache_classes = !ENV['CLASS_RELOADING']
  config.action_mailer.default_url_options = {host: 'example.com'}
  config.assets.precompile += %w( some-random-css.css some-random-js.js a/favicon.ico )
  config.active_record.maintain_test_schema = false
RUBY

gsub_file 'config/boot.rb', /^.*BUNDLE_GEMFILE.*$/, <<-RUBY
  ENV['BUNDLE_GEMFILE'] = "#{File.expand_path(ENV['BUNDLE_GEMFILE'])}"
RUBY

# Setup webpacker if necessary
if webpacker_app
  rails_command "webpacker:install"
  gsub_file 'config/webpacker.yml', /^(.*)extract_css.*$/, '\1extract_css: true' if ENV['RAILS_ENV'] == 'test'
end

# Setup Blazer
generate "blazer:install#{" --use-webpacker" if webpacker_app}"

# Force strong parameters to raise exceptions
inject_into_file 'config/application.rb', after: 'class Application < Rails::Application' do
  "\n    config.action_controller.action_on_unpermitted_parameters = :raise\n"
end


if ENV['RAILS_ENV'] != 'test'
  inject_into_file 'config/routes.rb', "\n  root to: redirect('admin')", after: /.*routes.draw do/
end

rails_command "db:drop db:create db:migrate", env: ENV['RAILS_ENV']

if ENV['RAILS_ENV'] == 'test'
  inject_into_file 'config/database.yml', "<%= ENV['TEST_ENV_NUMBER'] %>", after: 'test.sqlite3'

end

git add: "."
git commit: "-m 'Bare application'"