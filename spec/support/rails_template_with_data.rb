apply File.expand_path('rails_template.rb', __dir__)

append_file 'db/seeds.rb', "\n\n" + <<-RUBY.strip_heredoc
  users = ["Jimi Hendrix", "Jimmy Page", "Yngwie Malmsteen", "Eric Clapton", "Kirk Hammett"].collect do |name|
    first, last = name.split(" ")
    User.create!  first_name: first,
                  last_name: last,
                  username: [first,last].join('-').downcase,
                  age: rand(80),
                  encrypted_password: SecureRandom.hex
  end

  published_at_values = [Time.now.utc - 5.days, Time.now.utc - 1.day, nil, Time.now.utc + 3.days]
  10.times do |i|
    user = users[i % users.size]
    published = published_at_values[i % published_at_values.size]
    Post.create title: "Blog Post \#{i}",
                body: "Blog post \#{i} is written by \#{user.username}",
                published_date: published,
                starred: true
  end
RUBY

rails_command 'db:seed'

rails_command 'webpacker:install'

git add: '.'
git commit: "-m 'Bare application with data'"
