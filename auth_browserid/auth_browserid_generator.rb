class AuthBrowseridGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def build
    # Ajout de la gem
    file = 'Gemfile'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/devise_browserid_authenticatable/).size == 0
        inject_into_file file, :after => /gem 'devise'/ do
          "\ngem 'devise_browserid_authenticatable'"
        end
      end
    end
    # Generation
    run "bundle install"
    run "rails generate browser_id:install"
    # Configuration
    file = 'config/initializers/devise.rb'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/browserid_authenticatable/).size == 0
        inject_into_file file, :before => /^end/ do
          "\n\tconfig.warden do |manager| \n\t\tmanager.default_strategies(:scope => :user).unshift :browserid_authenticatable\n\tend\n"
        end
      end
    end
    file = 'app/views/layouts/application.html.haml'
    if FileTest.exists?(file) then
      if File.readlines(file).grep(/browserid_js_tag/).size == 0
        inject_into_file file, :before => /%body/ do
          "\t\t= browserid_js_tag\n"
        end
      end
    end
  end

end