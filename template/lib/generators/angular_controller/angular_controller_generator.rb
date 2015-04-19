require 'erb'

# This classe generates all the needed file of a angularjs/rails controller
class AngularControllerGenerator <  Rails::Generators::NamedBase
  include Initializer
  source_root File.expand_path("../templates", __FILE__)
  argument :model_attributes, type: :array, default: [], banner: "model:attributes"

  # Creates the ruby controller
  def create_ruby_controller
    template "controllers/api/v1/controller.rb.erb", "app/controllers/api/v1/#{class_name.tableize}.rb"
    tmp_file = "app/controllers/api/v1/base.rb"
    if FileTest.exists?(tmp_file) then
      inject_into_file tmp_file, :after => /Grape::API/ do
        "\n      mount API::V1::#{class_name.camelize.pluralize}"
      end
    end
  end

  # Add the new AngularJS routes in app/assets/javascripts/routes.js.coffee
  # @todo insert a erb rendered file into the file
  def add_angular_routes
    tmp_file = "app/assets/javascripts/routes.js.coffee"
    files_origin = File.expand_path(File.dirname(__FILE__))+"/templates"
    if FileTest.exists?(tmp_file) then
      if File.readlines(tmp_file).grep(/stateProvider/).size > 0 then
        if File.readlines(tmp_file).grep(/#{class_name.tableize}/).size <= 0 then
          open(tmp_file, 'a') { |f|
            f.puts ERB.new(File.read("#{files_origin}/assets/javascripts/routes.js.coffee.erb")).run
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

  # Creates the angularjs controller
  def create_angular_controller
    @AppName = Rails.application.class.name.split('::').first
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name.tableize}_ctrl.js"
    template "assets/javascripts/service.js.erb", "app/assets/javascripts/services/#{class_name.tableize}_srv.js.coffee"
  end
end