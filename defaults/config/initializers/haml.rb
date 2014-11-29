# Ajoute le helper haml dans assests
Rails.application.assets.context_class.class_eval do
  include HamlHelper
end