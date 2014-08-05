class AngularTemplateGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)


  # Creates js in assets/javascripts/controllers/CONTROLLER.js
  # Creates files in assets/templates/CONTROLLER
  #  * index.html.haml
  #  * edit.html.haml
  #  * show.html.haml
  #  * new.html.haml
  #  * _form.html.haml
  def template_angular_template_file
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name}.js"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name}/index.html.haml"
    template "assets/templates/edit.html.haml.erb", "app/assets/templates/#{class_name}/edit.html.haml"
    template "assets/templates/show.html.haml.erb", "app/assets/templates/#{class_name}/show.html.haml"
    template "assets/templates/new.html.haml.erb", "app/assets/templates/#{class_name}/new.html.haml"
    template "assets/templates/_form.html.haml.erb", "app/assets/templates/#{class_name}/_form.html.haml"
    # modify the templated files
    update_init
    update_application
  end

  # Creates ruby controller for the view api and admin actions
  def template_ruby_controller
    template "controllers/api/v1/controller.rb.erb", "app/controllers/api/v1/#{class_name.tableize}_controller.rb"
    template "controllers/admin/controller.rb.erb", "app/controllers/admin/#{class_name.tableize}_controller.rb"
    template "test/controllers/controller_test.rb.erb", "app/test/controllers/#{class_name.tableize}_controller_test.rb"
    template "test/fixtures/test.yml", "app/test/fixtures/test_#{class_name.tableize}.yml"
    template "test/helpers/helper_test.rb.erb", "app/test/helpers/#{class_name.tableize}_helper_test.rb"
    update_routes
  end

  private

    # Modify assets/javascripts/init.js or create if exists
    def update_init
      if FileTest.exists?("app/assets/javascripts/init.js") then
        inject_into_file 'app/assets/javascripts/init.js', :after => "'use strict';" do
          "\n\t// module pour les controleurs de #{class_name}s\n\tvar #{class_name.pluralize.camelize(:lower)}ModuleControllers = angular.module('#{class_name.pluralize.camelize(:lower)}ModuleControllers', []);"
        end
        gsub_file 'app/assets/javascripts/init.js', /'ngRoute',/, "'ngRoute', '#{class_name.pluralize.camelize(:lower)}ModuleControllers',"
      else
        put "Error, the application isn't templated for angularjs"
      end
    end

    # Modify assets/javascripts/application.js
    def update_application()
      _file = "app/assets/javascripts/application.js"
      if File.open(_file).each_line.any?{|line| line.include?('$routeProvider')}
        inject_into_file _file, :after => "$routeProvider." do
        "\n      when('/#{class_name}', {
          templateUrl: 'assets/#{class_name}/index.html',
          controller: '#{class_name.camelize(:upper)}sIndexController'
        }).
        when('/#{class_name}/:id', {
          templateUrl: 'assets/#{class_name}/show.html',
          controller: '#{class_name.camelize(:upper)}sShowController'
        })."
        end
        # Add the link in the menu
        gsub_file 'app/views/layouts/application.html.haml', /^(\s*)\%ul.nav.navbar-nav.navbar-right/ do
          "\$1%ul.nav.navbar-nav.navbar-right\n\1  %li\n\1    = link_to \"#{class_name}\", \"/#/#{class_name}\""
        end
      else
        put "Error, the application isn't templated for angularjs"
      end
    end

    # Updates routes with new api controller
    def update_routes
      # Routes for the views api (index, show)
      inject_into_file 'config/routes.rb', :after => "Application.routes.draw do" do
        "\n\t##{class_name} controller api\n\tnamespace :api, defaults: {format: 'json'} do\n\t\tnamespace :v1 do\n\t\t\tresources :#{class_name.tableize}\n\t\tend\n\tend\n"
      end
      # Routes needing an admin login (update, create, delete)
      inject_into_file 'config/routes.rb', :after => "Application.routes.draw do" do
        "\n\t##{class_name} controller admin\n\tnamespace :admin, defaults: {format: 'json'} do\n\t\tresources :#{class_name.tableize}\n\tend\n"
      end
    end

end
