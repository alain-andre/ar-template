require 'rails_helper'
require 'ammeter/init'
require 'rails/all'

# Generators are not automatically loaded by Rails
require 'generators/auth_browserid/auth_browserid_generator'

describe AuthBrowseridGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  dir = File.expand_path('../../../../../tmp', __FILE__)
  destination dir
  before do
    prepare_destination
  end

  # custom matchers make it easy to verify what the generator creates
  describe 'The generated files' do
    before do
      # Creates files modified in generator but created by template
      File.open("#{dir}/Gemfile", 'w'){|file| file.write("gem 'devise'")}
      FileUtils.mkdir_p("#{dir}/config/initializers/")
      File.open("#{dir}/config/initializers/devise.rb", "w"){|file| file.write('end')}
      FileUtils.mkdir_p("#{dir}/app/views/layouts/")
      File.open("#{dir}/app/views/layouts/application.html.haml", "w")
      FileUtils.mkdir_p("#{dir}/app/assets/javascripts/controllers/")
      File.open("#{dir}/app/assets/javascripts/controllers/browserid_ctrl.js.coffee", "w")
      # Run generator
      run_generator
    end

    describe 'in Gemfile' do
      subject { file('Gemfile') }
      it {is_expected.to contain(/devise_browserid_authenticatable/)}
    end
    
    describe 'in config/initializers/browser_id.rb' do 
      subject { file('config/initializers/browser_id.rb') }
      it { is_expected.to exist }
    end

    describe 'in config/initializers/devise.rb' do 
      subject { file('config/initializers/devise.rb') }
      it { is_expected.to exist }
      it {is_expected.to contain(/config\.warden/)}
    end

    describe 'in app/views/layouts/application.html.haml' do 
      subject { file('app/views/layouts/application.html.haml') }
      it { is_expected.to exist }
      it {is_expected.to contain(/browserid_js_tag/)}
    end

    describe 'in app/assets/javascripts/controllers/browserid_ctrl.js.coffee' do 
      subject { file('app/assets/javascripts/controllers/browserid_ctrl.js.coffee') }
      it { is_expected.to exist }
      it {is_expected.to contain(/\/users\/sign_out/)}
      it {is_expected.to contain(/\/users\/sign_in/)}
    end

    describe 'in app/views/layouts/_auth.html.haml' do 
      subject { file('app/views/layouts/_auth.html.haml') }
      it { is_expected.to exist }
      it {is_expected.to contain(/\=render 'layouts\/auth_browserid'/)}
    end

    describe 'in app/views/layouts/_auth_browserid.html.haml' do 
      subject { file('app/views/layouts/_auth_browserid.html.haml') }
      it { is_expected.to exist }
      it {is_expected.to contain(/user_signed_in?/)}
    end

  end

end