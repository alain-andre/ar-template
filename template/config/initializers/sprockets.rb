# Ajoute .haml au pipeline assets
Rails.application.assets.register_engine '.haml', Tilt::HamlTemplate

# add custom depend_on_config sprockets processor directive
class Sprockets::DirectiveProcessor
  def process_depend_on_config_directive(file)
    path = File.expand_path(file, Rails.root.join('config'))
    context.depend_on(path)
  end
end

# register .json for assets pipeline
Rails.application.assets.register_mime_type 'application/json', '.json'

# enable to use sprockets directive processor in .json
Rails.application.assets.register_preprocessor 'application/json', Sprockets::DirectiveProcessor