# Class generating a model with the given model attributes
class AngularModelGenerator < Rails::Generators::NamedBase
  include Initializer
  source_root File.expand_path("../templates", __FILE__)
  argument :model_attributes, type: :array, default: [], banner: "model:attributes"
  
  # Creates the migration
  def create_migration
  	template "db/migrate/migration.rb", "db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_create_#{class_name.tableize}.rb"
    rake 'db:migrate'
  end

  # Creates the ruby model
  def create_rb_model
    template "models/model.rb", "app/models/#{class_name.underscore.singularize}.rb"
  end
end