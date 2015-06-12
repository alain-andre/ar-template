require "rubygems"
require "bundler/setup"

package_dir = File.expand_path(File.dirname(__FILE__))

desc "Create a new project called test_app by default or use the given argument"
task :new_app, :directory do |t, args|
  if args.directory
    directory = args.directory
  else
    directory = "test_app"
  end
  cd ".." do
    rm_rf directory
    system "rails _4.0.0_ new #{directory} -m #{package_dir}/template.rb --skip-bundle --force"
    cd directory do
      Bundler.with_clean_env do
        system "bundle install"
        generate_rspec if ask("Generate rspec installation?", ['y', 'n']) == 'y'
        if ask("Add devise gem amd configure it?", ['y', 'n']) == 'y'
          generate_user(package_dir)
          add_role(package_dir) if ask("Add role to the user model?", ['y', 'n']) == 'y'
          auth_browserid(package_dir) if ask("Add browserid authentication?", ['y', 'n']) == 'y'
        end
        angular_scaffold if ask("Generate angular scaffolding?", ['y', 'n']) == 'y'
      end
    end
  end
end

desc "Travis test"
task :travis_test do
  directory = "travis_test"
  cd ".." do
    system "rails _4.0.0_ new #{directory} -m #{package_dir}/template.rb --skip-bundle --force"
    cd directory do
      Bundler.with_clean_env do
        system "bundle install"
        generate_rspec
      end
    end
  end
end

# RSPEC
def generate_rspec
  system "rails generate rspec:install"
  puts ".rspec added, remove --warning if you whant to skip messages"
  system "git add -A"
  system "git commit -m 'Install rspec'"
end

# Generate user structure and configure it
# @param package_dir : The package/template directory
def generate_user(package_dir)
  system "rails generate devise:install"

  replace('config/environments/development.rb',
    "config.action_mailer.raise_delivery_errors \= false",
    "config.action_mailer.raise_delivery_errors = false\n\tconfig.action_mailer.default_url_options = { host: 'localhost:3000' }")
  system "rails generate devise User"

  # make the authentication return a json
  dest = "app/controllers/sessions_controller.rb"
  File.new(dest, "w")
  FileUtils.cp "#{package_dir}/template/#{dest}", dest

  replace('config/routes.rb', 'devise_for :users', "devise_for :users, :controllers => { sessions: 'sessions' } ")

  system "git add -A"
  system "git commit -m 'Add devise and configure it'"
end

# Add roles to user and create an admin
# @param package_dir : The package/template directory
def add_role(package_dir)
  replace('app/models/user.rb',
    "Base",
    "Base\n  enum role: [:default_user, :admin]\n  before_validation :set_default_role, :if => :new_record?\n  # Return true if User is an Admin\n  def is_admin?\n    self.role == \"admin\" ? true : false\n  end\n  # Define the default role\n  def set_default_role\n    self.role ||= :default_user\n  end\n")

  dest = "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_add_role_to_users.rb"
  File.new(dest, "w")
  FileUtils.cp "#{package_dir}/template/db/migrate/add_role_to_users.rb", dest
  system "rake db:migrate"

  file = 'db/seeds.rb'
  open(file, 'a') { |f| f.puts File.read("#{package_dir}/template/#{file}") }
  system "bundle exec figaro install"

  admin_user = get_stdin("What's the email of the admin user ? ")
  file = 'config/application.yml'
  open(file, 'a') { |f| f.puts "ADMIN_EMAIL: #{admin_user}" }
  system "rake db:seed"

  puts "============================================================"
  puts "Remember You can modify this email in config/application.yml"
  puts "============================================================"

  system "git add -A"
  system "git commit -m 'Add roles to user'"
end

# Plug a browserid authentication into the project using it's generator
# @param package_dir : The package/template directory
# @params has_admins
def auth_browserid(package_dir)
  replace('Gemfile',
    "gem 'devise'",
    "gem 'devise'\ngem 'devise_browserid_authenticatable'")
  
  Bundler.with_clean_env do
    system "bundle install"
  end
  system "rails g auth_browserid"
  
  system "git add -A"
  system "git commit -m 'Add browserid_authentication'"
end

# Plug a scaffoled angular object into the project using it's generator
def angular_scaffold
  object = get_stdin("What is the Object name to scaffold? ")
  puts "Describe your structure like a model generation :\nnom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime"
  parameters = get_stdin("What's the structure of the object? ")
  system "rails generate angular_scaffold #{object} #{parameters}"
end

# Prompt a message and return the user catched response
# @param message : The message to prompt
# @return the user catched response
def get_stdin(message)
  print message
  STDIN.gets.chomp
end

# Ask a question to the user using the prompt until it can return one of the authorised response.
# @param message : The message to the user
# @param valid_options : An array of valid options
# @return The answer
def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

# Replace in a file the original text by the new one
# @param file : The file to modify
# @param original_text : The original text
# @param new_text : The text to replace with
def replace(file, original_text, new_text)
  text=File.open(file).read
  text.gsub!("#{original_text}", "#{new_text}")
  File.open(file, 'w') { |f| f.puts text }
end
