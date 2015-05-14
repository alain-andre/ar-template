# This class generates all the needed AngularJS templates  with the I18 file
class AngularViewsGenerator < Rails::Generators::NamedBase
  include Initializer
  source_root File.expand_path("../templates", __FILE__)
  argument :model_attributes, type: :array, default: [], banner: "model:attributes"
  
  # Generates the needed templates
  def create_templates
    files = %w(_filter _form index admin edit show new)
    files.each do |file|
      template "assets/templates/#{file}.html.haml.erb", "app/assets/templates/#{class_name.tableize}/#{file}.html.haml"
    end
  end

  # Generates the I18 file
  def create_local
    template "config/locales/en.rb", "config/locales/#{class_name.underscore}.en.yml"
  end

  # Add to git
  def add_to_git
    run "git add -A"
    run "git commit -m 'Generated angular views for #{class_name}'"
  end

end