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
    copy_file "assets/javascripts/controller.js.erb", "app/assets/javascripts/controllers/#{class_name}.js"
    # directory "assets/templates", "app/assets/templates/#{class_name}/"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name}/index.html.haml"
  end

  # modify text of the copyed files
  def update_template_file
    update_index get_camelized_class
    update_edit get_camelized_class
    update_show get_camelized_class
    update_new get_camelized_class
    update_form get_camelized_class
    update_init get_camelized_class
    update_application get_camelized_class
  end

  private
    # Modify index
    def update_index camelized_class
      # gsub_file "app/assets/templates/#{class_name}/index.html.haml", /class_name/ do |match|
      #   match << "#{class_name}"
      # end
      # gsub_file "app/assets/templates/#{class_name}/index.html.haml", /camelized_class/ do |match|
      #   match << "#{camelized_class}"
      # end
    end

    # Modify edit
    def update_edit camelized_class
    end

    # Modify show
    def update_show camelized_class
    end

    # Modify new
    def update_new camelized_class
    end

    # Modify _form
    def update_form camelized_class
    end

    # Modify assets/javascripts/init.js or create if exists
    def update_init camelized_class
      # if FileTest.exists?("app/assets/javascripts/init.js") then
#       // module pour les controleurs de projects
# var projectsModuleControllers = angular.module('projectsModuleControllers', []);
# var defaultModuleControllers = angular.module('defaultModuleControllers', []);

# // Création de l'application
# var maSuperApp = angular.module('maSuperApp', ['ngRoute',
#   'projectsModuleControllers', 'defaultModuleControllers'
# ]);
      # else
#       put "Error, the application isn't templated for angularjs"
      # end
    end

    # Modify assets/javascripts/application.js
    def update_application(camelized_class)
  #     _file = "app/assets/javascripts/application.js"
  #     if File.open(_file).each_line.any?{|line| line.include?('$routeProvider')}
  #       inject_into_file _file, :after => "$routeProvider." do
  # "\nwhen('/#{class_name}', {
  #   templateUrl: 'assets/templates/#{class_name}/index.html',
  #   controller: '#{camelized_class}Controller'
  # }).
  # when('/#{class_name}/:id', {
  #   templateUrl: 'assets/templates/#{class_name}/show.html',
  #   controller: '#{camelized_class}ShowController'
  # })."
  #       end
  #     else
  #       put "Error, the application isn't templated for angularjs"
  #     end
    end

    def get_camelized_class
      camelized_class = class_name.camelize(:lower)
    end

    def get_downcased_class
      downcased_class = class_name.downcase
    end
end
