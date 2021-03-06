module HamlHelper
  def render_haml(filename)
    contents = File.read(Rails.root.join("app", "assets", "templates", filename))
    Haml::Engine.new(contents).render
  end
end