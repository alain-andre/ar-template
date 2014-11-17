# Ajoute .haml au pipeline assets
Rails.application.assets.register_engine '.haml', Tilt::HamlTemplate
