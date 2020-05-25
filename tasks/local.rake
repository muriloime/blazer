desc 'Run a command against the local sample application'
task :local do
  require_relative 'test_application'

  test_application = Blazer::TestApplication.new(
    rails_env: 'development',
    template: 'rails_template_with_data'
  )

  test_application.soft_generate

  # Discard the "local" argument (name of the task)
  argv = ARGV[1..-1]

  if argv.any?
    # If it's a rails command, auto add the rails script
    argv.unshift('rails') if %w[generate console server dbconsole g c s runner].include?(argv[0]) || argv[0] =~ /db:/

    command = ['bundle', 'exec', *argv].join(' ')
    env = { 'BUNDLE_GEMFILE' => test_application.expanded_gemfile }

    Dir.chdir(test_application.app_dir) do
      Bundler.with_original_env { Kernel.exec(env, command) }
    end
  end
end
