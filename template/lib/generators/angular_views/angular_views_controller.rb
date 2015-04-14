# This class generates all the needed AngularJS templates  with the I18 file
class AngularViewsGenerator < Rails::Generators::NamedBase
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

  # Generates the needed templates
  def create_templates
    template "assets/templates/_filter.html.haml.erb", "app/assets/templates/#{class_name.tableize}/_filter.html.haml"
    template "assets/templates/index.html.haml.erb", "app/assets/templates/#{class_name.tableize}/index.html.haml"
    template "assets/templates/admin.html.haml.erb", "app/assets/templates/#{class_name.tableize}/admin.html.haml"
    template "assets/templates/edit.html.haml.erb", "app/assets/templates/#{class_name.tableize}/edit.html.haml"
    template "assets/templates/show.html.haml.erb", "app/assets/templates/#{class_name.tableize}/show.html.haml"
    template "assets/templates/new.html.haml.erb", "app/assets/templates/#{class_name.tableize}/new.html.haml"
    template "assets/templates/_form.html.haml.erb", "app/assets/templates/#{class_name.tableize}/_form.html.haml"
  end

  # Generates the I18 file
  def create_local
    template "config/locales/en.rb", "config/locales/#{class_name.underscore}.en.yml"
  end


end