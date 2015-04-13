require 'ammeter/init'
require 'rails/generators'

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

    # @todo https://github.com/alain-andre/ar-template/issues/15
    describe 'in Gemfile' do
      subject { file('Gemfile') }
      pending "Test if Gemfile contains devise_browserid_authenticatable"
    #  it {is_expected.to contain(/devise_browserid_authenticatable/)}
    end
    
    # @todo https://github.com/alain-andre/ar-template/issues/20
    describe 'in config/initializers/browser_id.rb' do 
      pending "Test if browser_id.rb exists"
      subject { file('config/initializers/browser_id.rb') }
      # it { is_expected.to exist }
    end

    describe 'in config/initializers/devise.rb' do 
      subject { file('config/initializers/devise.rb') }
      it { is_expected.to exist }
      # @todo https://github.com/alain-andre/ar-template/issues/15
      # it {is_expected.to contain(/config.warden/)}
    end

    describe 'in app/views/layouts/application.html.haml' do 
      subject { file('app/views/layouts/application.html.haml') }
      it { is_expected.to exist }
      # @todo https://github.com/alain-andre/ar-template/issues/15
      pending "test if application.html.haml contains browserid_js_tag"
      # it {is_expected.to contain(/browserid_js_tag/)}
    end

    # @todo https://github.com/alain-andre/ar-template/issues/15
    describe 'in app/assets/javascripts/controllers/browserid_ctrl.js.coffee' do 

      subject { file('app/assets/javascripts/controllers/browserid_ctrl.js.coffee') }
      it { is_expected.to exist }
      pending "Test if browserid_ctrl.js.coffee contains sign buttons"
    #  buttons = %w(users/sign_out users/sign_in)
    #  it 'contains the login/logout buttons' do
    #    buttons.each do |button|
    #      expect(subject).to contain(button)
    #    end
    #  end
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