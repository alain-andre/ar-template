class AngularScaffoldGenerator < Rails::Generators::NamedBase
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
