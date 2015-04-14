# This classe generates all the needed file of a angularjs/rails controller
class AngularControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  argument :model_attributes, type: :array, default: [], banner: "model:attributes"

  # Initialize the generator accepting model attributes as arguments
  def initialize(*args, &block)
    super
    @attributes = []
    model_attributes.each do |attribute|
      @attributes << Rails::Generators::GeneratedAttribute.new(*attribute.split(":")) if attribute.include?(":")
    end
  end

  # Creates the ruby controller
  def create_ruby_controller
    template "controllers/api/v1/controller.rb.erb", "app/controllers/api/v1/#{class_name.tableize}.rb"
    tmp_file = "app/controllers/api/v1/base.rb"
    if FileTest.exists?(tmp_file) then
      inject_into_file tmp_file, :after => /Grape::API/ do
        "\n      mount API::V1::#{class_name.camelize.pluralize}"
      end
    end

  # Add the new AngularJS routes in app/assets/javascripts/routes.js.coffee
  # @todo insert a erb rendered file into the file
  def add_angular_routes()
    tmp_file = "app/assets/javascripts/routes.js.coffee"
    if FileTest.exists?(tmp_file) then
      if File.readlines(tmp_file).grep(/stateProvider/).size > 0
        if File.readlines(tmp_file).grep(/#{class_name.tableize}/).size <= 0
          open(tmp_file, 'a') { |f|
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
})
if Rails.is_admin
  # #{class_name.tableize} : admin actions
  $stateProvider.state('admin#{class_name.camelize(:upper)}', { 
    # state for showing all #{class_name.tableize}
    url: '/admin/#{class_name.tableize}',
    templateUrl: '#{class_name.tableize}/admin.html',
    controller: '#{class_name.camelize(:upper)}ListCtrl'
  }).state('new#{class_name.camelize(:upper)}', { 
    #state for adding a new #{class_name.camelize(:upper)}
    url: '/admin/#{class_name.tableize}/new',
    templateUrl: '#{class_name.tableize}/new.html',
    controller: '#{class_name.camelize(:upper)}CreateCtrl'
  }).state('edit#{class_name.camelize(:upper)}', { 
    #state for updating a #{class_name.camelize(:upper)}
    url: '/admin/#{class_name.tableize}/:id/edit',
    templateUrl: '#{class_name.tableize}/edit.html',
    controller: '#{class_name.camelize(:upper)}EditCtrl'
  })"
              }
          else
            say "Warning, #{class_name.tableize} already set in routes #{tmp_file}"
          end
        else
          say "Warning, $stateProvider not found in routes #{tmp_file}"
        end
      else
        say "Error, cannot find file #{tmp_file}"
      end
    end
  end

  # Creates the angularjs controller
  def create_angular_controller
    @AppName = Rails.application.class.name.split('::').first
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name.tableize}_ctrl.js"
    template "assets/javascripts/service.js.erb", "app/assets/javascripts/services/#{class_name.tableize}_srv.js.coffee"
  end
end