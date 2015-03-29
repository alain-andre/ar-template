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
          add_role if ask("Add role to the user model?", ['y', 'n']) == 'y'
          auth_browserid if ask("Add browserid authentication?", ['y', 'n']) == 'y'
        end
        angular_scaffold if ask("Generate angular scaffolding?", ['y', 'n']) == 'y'
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

  file = 'config/environments/development.rb'
  text=File.open(file).read
  text.gsub!(/config.action_mailer.raise_delivery_errors \= false/, 
    "config.action_mailer.raise_delivery_errors = false\n\tconfig.action_mailer.default_url_options = { host: 'localhost:3000' }")
  File.open(file, 'w') { |f| f.puts text }

  system "rails generate devise User"
  dest = "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_add_role_to_users.rb"
  File.new(dest, "w")
  FileUtils.cp "#{package_dir}/template/db/migrate/add_role_to_users.rb", dest

  system "git add -A"
  system "git commit -m 'Add devise and configure it'"
end

# Add roles to user and run the migration
def add_role
  file = 'app/models/user.rb'
  text=File.open(file).read
  text.gsub!(/Base/, 
    "Base\n  enum role: [:default_user, :admin]\n  before_validation :set_default_role, :if => :new_record?\n  # Return true if User is an Admin\n  def is_admin?\n    self.role == \"admin\" ? true : false\n  end\n  # Define the default role\n  def set_default_role\n    self.role ||= :default_user\n  end\n")
  File.open(file, 'w') { |f| f.puts text }

  system "rake db:migrate"
  File.open('db/seeds.rb', 'a') { |f| f.puts "\nUser.last.update(:role => 1)" }

  system "git add -A"
  system "git commit -m 'Add roles to user'"
end

# Plug a browserid authentication into the project using it's generator
def auth_browserid
  file = 'Gemfile'
  text=File.open(file).read
  text.gsub!(/gem 'devise'/, 
    "gem 'devise'\ngem 'devise_browserid_authenticatable'")
  File.open(file, 'w') { |f| f.puts text }
  Bundler.with_clean_env do
    system "bundle install"
  end
  system "rails g auth_browserid"
end

# Plug a scaffoled angular object into the project using it's generator
def angular_scaffold
  object = get_stdin("What is the Object name to scaffold? ")
  puts "Describe your structure like a çodel generation :\nnom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime"
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
