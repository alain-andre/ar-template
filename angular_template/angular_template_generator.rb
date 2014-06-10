class AngularTemplateGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)


  # - Crée le js dans assets/javascripts/controllers/CONTROLLER.js
  # - Crée les fichiers dans assets/templates/CONTROLLER
  #  - index.html.haml
  #  - edit.html.haml
  #  - show.html.haml
  #  - new.html.haml
  #  - _form.html.haml
  def copy_angular_template_file
    template "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name}.js"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name}/index.html.haml"
    template "assets/templates/show.html.haml.erb", "app/assets/templates/#{class_name}/show.html.haml"
    template "assets/templates/new.html.haml.erb", "app/assets/templates/#{class_name}/new.html.haml"
  end

  # modify text of the copyed files
  def update_template_file
    update_init get_camelized_class
    update_application get_camelized_class
  end

  private

    # Modify assets/javascripts/init.js or create if exists
    def update_init camelized_class
      if FileTest.exists?("app/assets/javascripts/init.js") then
        inject_into_file 'app/assets/javascripts/init.js', :after => "'use strict';" do
          "\n\t// module pour les controleurs de #{class_name}s\n\tvar #{get_camelized_class}sModuleControllers = angular.module('#{get_camelized_class}sModuleControllers', []);"
        end
        gsub_file 'app/assets/javascripts/init.js', /'ngRoute',/, "'ngRoute', '#{get_camelized_class}sModuleControllers',"
      else
        put "Error, the application isn't templated for angularjs"
      end
    end

    # Modify assets/javascripts/application.js
    def update_application(camelized_class)
      _file = "app/assets/javascripts/application.js"
      if File.open(_file).each_line.any?{|line| line.include?('$routeProvider')}
        inject_into_file _file, :after => "$routeProvider." do
        "\nwhen('/#{class_name}', {
          templateUrl: 'assets/templates/#{class_name}/index.html',
          controller: '#{camelized_class}sIndexController'
        }).
        when('/#{class_name}/:id', {
          templateUrl: 'assets/templates/#{class_name}/show.html',
          controller: '#{camelized_class}sShowController'
        })."
        end
      else
        put "Error, the application isn't templated for angularjs"
      end
    end

    def get_camelized_class
      camelized_class = class_name.camelize(:lower)
    end

    def get_downcased_class
      downcased_class = class_name.downcase
    end
end
