class AngularScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  # Creates the AngularJS controller in `assets/javascripts/controllers/`
  # Creates files in assets/templates/#{class_name}
  #  * index.html.haml
  #  * edit.html.haml
  #  * show.html.haml
  #  * new.html.haml
  #  * _form.html.haml
  def template_angular_template_file
    @AppName = Rails.application.class.name.split('::').first
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name.underscore.pluralize}_ctrl.js"
    template "assets/javascripts/service.js.erb", "app/assets/javascripts/services/#{class_name.underscore.pluralize}_srv.js.coffee"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name.underscore.pluralize}/index.html.haml"
    template "assets/templates/edit.html.haml.erb", "app/assets/templates/#{class_name.underscore.pluralize}/edit.html.haml"
    template "assets/templates/show.html.haml.erb", "app/assets/templates/#{class_name.underscore.pluralize}/show.html.haml"
    template "assets/templates/new.html.haml.erb", "app/assets/templates/#{class_name.underscore.pluralize}/new.html.haml"
    template "assets/templates/_form.html.haml.erb", "app/assets/templates/#{class_name.underscore.pluralize}/_form.html.haml"
    # modify the templated files
    #update_init
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
    # def update_init
    #   if FileTest.exists?("app/assets/javascripts/init.js") then
    #     inject_into_file 'app/assets/javascripts/init.js', :after => "'use strict';" do
    #       "\n\t// module pour les controleurs de #{class_name}s\n\tvar #{class_name.pluralize.camelize(:lower)}ModuleControllers = angular.module('#{class_name.pluralize.camelize(:lower)}ModuleControllers', []);"
    #     end
    #     gsub_file 'app/assets/javascripts/init.js', /'ngRoute',/, "'ngRoute', '#{class_name.pluralize.camelize(:lower)}ModuleControllers',"
    #   else
    #     put "Error, the application isn't templated for angularjs"
    #   end
    # end

    # Add the new AngularJS routes in app/assets/javascripts/routes.js.coffee
    # @todo : ajouter les routes pour CRUD en restfull
    def update_application()
      file = "app/assets/javascripts/routes.js.coffee"
      if FileTest.exists?(file) then
        if File.readlines(file).grep(/stateProvider/).size > 0
          if File.readlines(file).grep(/#{class_name.underscore.pluralize}/).size <= 0
            open(file, 'a') { |f|
              f.puts "\n
  # #{class_name.underscore.pluralize}
  $stateProvider.state('#{class_name.underscore.pluralize}', { 
    # state for showing all #{class_name.underscore.pluralize}
    url: '/#{class_name.underscore.pluralize}',
    templateUrl: '#{class_name.underscore.pluralize}/index.html',
    controller: '#{class_name.camelize(:upper)}ListCtrl'
  }).state('view#{class_name.camelize(:upper)}', { 
    #state for showing single #{class_name.camelize(:upper)}
    url: '/#{class_name.underscore.pluralize}/:id/view',
    templateUrl: '#{class_name.underscore.pluralize}/show.html',
    controller: '#{class_name.camelize(:upper)}ViewCtrl'
  }).state('new#{class_name.camelize(:upper)}', { 
    #state for adding a new #{class_name.camelize(:upper)}
    url: '/#{class_name.underscore.pluralize}/new',
    templateUrl: '#{class_name.underscore.pluralize}/new.html',
    controller: '#{class_name.camelize(:upper)}CreateCtrl'
  }).state('edit#{class_name.camelize(:upper)}', { 
    #state for updating a #{class_name.camelize(:upper)}
    url: '/#{class_name.underscore.pluralize}/:id/edit',
    templateUrl: '#{class_name.underscore.pluralize}/edit.html',
    controller: '#{class_name.camelize(:upper)}EditCtrl'
  })
"
            }
          else
            say "Warning, #{class_name.underscore.pluralize} already set in routes #{file}"
          end
        else
          say "Warning, $stateProvider not found in routes #{file}"
        end
      else
        say "Error, cannot find file #{file}"
      end
    end

    # Updates Rails routes with new api controller
    def update_routes
      file = "config/routes.rb"
      # Routes for the views api (index, show)
      if File.readlines(file).grep(/##{class_name} controller api/).size <= 0
        inject_into_file file, :before => /^end/ do
          "\n  ##{class_name} controller api\n  namespace :api, defaults: {format: 'json'} do\n    namespace :v1 do\n      resources :#{class_name.tableize}\n    end\n  end\n"
        end
      else
        say "Warning, #{class_name} controller api already set in routes #{file}"
      end
      # Routes needing an admin login (update, create, delete)
      if File.readlines(file).grep(/##{class_name} controller admin/).size <= 0
        inject_into_file file, :before => /^end/ do
          "\n  ##{class_name} controller admin\n  namespace :admin, defaults: {format: 'json'} do\n    resources :#{class_name.tableize}\n  end\n"
        end
      else
        say "Warning, #{class_name} controller admin already set in routes #{file}"
      end
    end

end
