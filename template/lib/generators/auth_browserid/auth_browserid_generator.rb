class AuthBrowseridGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  # Insert the gem devise_browserid_authenticatable into Gemfile
  def insert_gemfile
    file = 'Gemfile'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/devise_browserid_authenticatable/).size <= 0
        inject_into_file file, :after => /gem 'devise'/ do
          "\ngem 'devise_browserid_authenticatable'"
        end
        run "bundle install"
      else
        say "'devise' already added !"
      end
    else
      say "'Gemfile' does not exists !"
    end
  end

  # Generate browser_id:install
  def generate_browserid
    # Generation
    file = 'config/initializers/browser_id.rb'
    if FileTest.exists?(file) then
      say "skeeping generation as 'config/initializers/browser_id.rb' already exists !"
    else
      run "rails generate browser_id:install"
    end
  end

  # Configure Devise for browserid_authenticatable
  def config_devise
    file = 'config/initializers/devise.rb'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/browserid_authenticatable/).size <= 0
        inject_into_file file, :before => /^end/ do
          "\n  config.warden do |manager| \n    manager.default_strategies(:scope => :user).unshift :browserid_authenticatable\n  end\n"
        end
      else
        say "'browserid_authenticatable' already added !"
      end
    else
      say "'config/initializers/devise.rb' does not exists !"
    end
  end

  # Add browserid javascripts
  def add_browserid_js_tag
    file = 'app/views/layouts/application.html.haml'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/browserid_js_tag/).size <= 0
        inject_into_file file, :before => /%body/ do
          "  = browserid_js_tag\n  "
        end
        file = 'app/assets/javascripts/controllers/browserid_ctrl.js.coffee'
        @AppName = Rails.application.class.name.split('::').first
        template file+'.erb', file
      else
        say "'browserid_js_tag' already added !"
      end
    else
      say "'app/views/layouts/application.html.haml' does not exists !"
    end
  end

  # Template the login buttons
  # It will create the partial 'layouts/auth_browserid' showing a BrowserId button
  def render_the_login
    file = 'app/views/layouts/_auth.html.haml'
    template file, file, force: true

    file = 'app/views/layouts/_auth_browserid.html.haml'
    template file, file
  end

  # Add to git
  def add_to_git
    run "git add -A"
    run "git commit -m 'Generated browserid authentication for the app.'"
  end

end