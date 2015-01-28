class AngularScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  argument :model_attributes, type: :array, default: [], banner: "model:attributes"

  def initialize(*args, &block)
    super
    @attributes = []
    model_attributes.each do |attribute|
      @attributes << Rails::Generators::GeneratedAttribute.new(*attribute.split(":")) if attribute.include?(":")
    end
  end
  
  # Creates the AngularJS controller in `assets/javascripts/controllers/`
  # Creates files in assets/templates/#{class_name}
  #  * index.html.haml
  #  * edit.html.haml
  #  * show.html.haml
  #  * new.html.haml
  #  * _form.html.haml
  def template_angular_template_file
    @AppName = Rails.application.class.name.split('::').first
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name.tableize}_ctrl.js"
    template "assets/javascripts/service.js.erb", "app/assets/javascripts/services/#{class_name.tableize}_srv.js.coffee"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name.tableize}/index.html.haml"
    template "assets/templates/edit.html.haml.erb", "app/assets/templates/#{class_name.tableize}/edit.html.haml"
    template "assets/templates/show.html.haml.erb", "app/assets/templates/#{class_name.tableize}/show.html.haml"
    template "assets/templates/new.html.haml.erb", "app/assets/templates/#{class_name.tableize}/new.html.haml"
    template "assets/templates/_form.html.haml.erb", "app/assets/templates/#{class_name.tableize}/_form.html.haml"
    # AngularJS routes
    update_application
  end

  # Creates ruby controller for the view api and admin actions
  def template_ruby_controller
    template "controllers/api/v1/controller.rb.erb", "app/controllers/api/v1/#{class_name.tableize}.rb"
    file = "app/controllers/api/v1/base.rb"
    if FileTest.exists?(file) then
      inject_into_file file, :after => /Grape::API/ do
        "\n      mount API::V1::#{class_name.camelize.pluralize}"
      end
    end
    template "test/controllers/controller_test.rb.erb", "app/test/controllers/#{class_name.tableize}_controller_test.rb"
    template "test/fixtures/test.yml", "app/test/fixtures/test_#{class_name.tableize}.yml"
    template "test/helpers/helper_test.rb.erb", "app/test/helpers/#{class_name.tableize}_helper_test.rb"
    # Create the model
    template "models/model.rb", "app/models/#{class_name.underscore}.rb"
    # Create the migration
    template "db/migrate/migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M")}_create_#{class_name.tableize}.rb"
    # I18
    template "config/locales/en.rb", "config/locales/#{class_name.underscore}.en.yml"
  end

  private
    # Add the new AngularJS routes in app/assets/javascripts/routes.js.coffee
    def update_application()
      file = "app/assets/javascripts/routes.js.coffee"
      if FileTest.exists?(file) then
        if File.readlines(file).grep(/stateProvider/).size > 0
          if File.readlines(file).grep(/#{class_name.tableize}/).size <= 0
            open(file, 'a') { |f|
              f.puts "\n
  # #{class_name.tableize}
  $stateProvider.state('#{class_name.tableize}', { 
    # state for showing all #{class_name.tableize}
    url: '/#{class_name.tableize}',
    templateUrl: '#{class_name.tableize}/index.html',
    controller: '#{class_name.camelize(:upper)}ListCtrl'
  }).state('view#{class_name.camelize(:upper)}', { 
    #state for showing single #{class_name.camelize(:upper)}
    url: '/#{class_name.tableize}/:id/view',
    templateUrl: '#{class_name.tableize}/show.html',
    controller: '#{class_name.camelize(:upper)}ViewCtrl'
  }).state('new#{class_name.camelize(:upper)}', { 
    #state for adding a new #{class_name.camelize(:upper)}
    url: '/#{class_name.tableize}/new',
    templateUrl: '#{class_name.tableize}/new.html',
    controller: '#{class_name.camelize(:upper)}CreateCtrl'
  }).state('edit#{class_name.camelize(:upper)}', { 
    #state for updating a #{class_name.camelize(:upper)}
    url: '/#{class_name.tableize}/:id/edit',
    templateUrl: '#{class_name.tableize}/edit.html',
    controller: '#{class_name.camelize(:upper)}EditCtrl'
  })
"
            }
          else
            say "Warning, #{class_name.tableize} already set in routes #{file}"
          end
        else
          say "Warning, $stateProvider not found in routes #{file}"
        end
      else
        say "Error, cannot find file #{file}"
      end
    end

end
