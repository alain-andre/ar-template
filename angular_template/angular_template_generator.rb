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
    copy_file "controller.js.erb", "assets/javascripts/controllers/#{class_name}.js"
    directory "assets/templates", "assets/templates/#{class_name}/"
    update_template_file
  end

  # modify text of the copyed files
  def update_template_file
    update_index get_capitalized_class_name
    update_edit get_capitalized_class_name
    update_show get_capitalized_class_name
    update_new get_capitalized_class_name
    update_form get_capitalized_class_name
    update_init get_capitalized_class_name
    update_application get_capitalized_class_name
  end

  # Modify index
  def update_index capitalized_class_name
    gsub_file "assets/templates/#{class_name}/index.html.haml", /class_name/ do |match|
      match << "#{class_name}"
    end
    gsub_file "assets/templates/#{class_name}/index.html.haml", /capitalized_class_name/ do |match|
      match << "#{capitalized_class_name}"
    end
  end

  # Modify edit
  def update_edit capitalized_class_name
  end

  # Modify show
  def update_show capitalized_class_name
  end

  # Modify new
  def update_new capitalized_class_name
  end

  # Modify _form
  def update_form capitalized_class_name
  end

  # Modify assets/javascripts/init.js or create if exists
  def update_init capitalized_class_name
    if file_exists?("assets/javascripts/init.js") then
    else

    end
  end

  # Modify assets/javascripts/application.js
  def update_application(capitalized_class_name)
    _file = "assets/javascripts/application.js"
    if File.open(_file).lines.any?{|line| line.include?('$routeProvider')}
      inject_into_file _file, :after => "$routeProvider." do
"\nwhen('/#{class_name}', {
  templateUrl: 'assets/templates/#{class_name}/index.html',
  controller: '#{capitalized_class_name}Controller'
}).
when('/#{class_name}/:id', {
  templateUrl: 'assets/templates/#{class_name}/show.html',
  controller: '#{capitalized_class_name}ShowController'
})."
      end
    else
      put "Error, the application isn't templated for angularjs"
    end    
  end

  private
  def get_capitalized_class_name
    capitalized_class_name = class_name
    capitalized_class_name[0] = capitalized_class_name[0].capitalize
    capitalized_class_name
  end
end