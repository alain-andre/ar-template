class AngularScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  argument :model_attributes, type: :array, default: [], banner: "model:attributes"
  
  # Creates the rails and angularjs controller
  def create_controller
    generate("angular_controller", class_name.tableize, model_attributes.join(" "))
  end

  # Creates the rails model
  def create_model
    generate("angular_model", class_name.tableize, model_attributes.join(" "))
  end

  # Creates the angularjs views
  def create_views
    generate("angular_views", class_name.tableize, model_attributes.join(" "))
  end

end
