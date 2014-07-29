# vars
@appName = @app_name.camelize(:lower)

# gem
FileUtils.cp(File.expand_path(File.dirname(__FILE__))+"/defaults/Gemfile_", "Gemfile")

run "bundle install"
git :init
git add: "-A"
git commit: '-m "Définition des gems du projet"'

#
say "Configuration des gems angularjs"
inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
  "//= require angular\n//= require angular-route"
end

inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
  "\n//= require angular-ui-bootstrap"
end

inject_into_file 'app/assets/stylesheets/application.css', :after => "*/" do
  "\n\n@import \"bootstrap.css\";"
end

git add: "-A"
git commit: '-m "Configuration du css bootstrap pour angular"'

inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
  "\n//= require angular-ujs"
end
gsub_file 'app/assets/javascripts/application.js', /\/\/= require jquery/, "//"
gsub_file 'app/assets/javascripts/application.js', /\/\/_ujs/, "//"

#
say "Configuration de l'application angularjs"
gsub_file 'app/views/layouts/application.html.erb', /<html>/, "<html lang=\"fr\" ng-app=\"#{@appName}\">"

File.new("app/assets/javascripts/init.js", "w")
append_to_file 'app/assets/javascripts/init.js' do
  "'use strict';\n\t// initialisation de l'application\n\tvar #{@appName} = angular.module('#{@appName}', ['ngRoute', 'angular.ujs']);"
end

inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
  "\n//= require init\n"
end

git add: "-A"
git commit: '-m "Configuration des scripts pour angular"'

run "rails generate devise:install"
inject_into_file 'config/environments/development.rb', :after => "config.action_mailer.raise_delivery_errors = false" do
  "\n\tconfig.action_mailer.default_url_options = { host: 'localhost:3000' }"
end

inject_into_file 'app/controllers/application_controller.rb', :after => "protect_from_forgery with: :exception" do
  "\n\tbefore_filter :authenticate_user!"
end

run "rails generate devise User"
rake 'db:migrate'

directory File.expand_path(File.dirname(__FILE__))+"/defaults/devise", "app/views/devise"

inject_into_file 'config/application.rb', :after => "# config.i18n.default_locale = :de" do
  "\n\t\tconfig.i18n.default_locale = :fr\n"
end

git add: "-A"
git commit: '-m "Generation de User et devise:views + internationalisation"'

file = File.open(File.expand_path(File.dirname(__FILE__))+"/defaults/application_yield", "rb")
gsub_file 'app/views/layouts/application.html.erb', /<%= yield %>/, file.read
gsub_file 'app/views/layouts/application.html.erb', /app_name/, "#{@appName}"

git add: "-A"
git commit: '-m "Ajout de la barre menu + messages dans app/views/layouts/application.html.erb"'

#
say "Création de l'architecture pour la gestion des templates angularjs"
file = File.open(File.expand_path(File.dirname(__FILE__))+"/defaults/application_js", "rb")
inject_into_file 'app/assets/javascripts/application.js', :after => "//= require_tree ." do
  "\n\n"+file.read
end
gsub_file 'app/assets/javascripts/application.js', /app_name/, "#{@appName}"

#
say "Ajout du dossier templates dans la configuration assets"
inject_into_file 'config/application.rb', :after => "Rails::Application" do
  "\n\t\tconfig.assets.paths << Rails.root.join('app', 'assets', 'templates')"
end

#
say "Prise en compte du HAML dans assets"
File.new("config/initializers/haml.rb", "w")
append_to_file 'config/initializers/haml.rb' do
  "\nRails.application.assets.register_engine '.haml', Tilt::HamlTemplate"
end

git add: "-A"
git commit: '-m "Création de l\'architecture pour la gestion des templates angularjs"'

#
say "Initialisation du generateur de scaffolding"
directory File.expand_path(File.dirname(__FILE__))+"/angular_template", "lib/generators/angular_template"

run "rails g controller home index --skip-assets"
File.write('app/views/home/index.html.erb', "\n<div ng-view></div>")

gsub_file 'config/routes.rb', /# root 'welcome#index'/, "root 'home#index'"

# Modification des generateurs
inject_into_file 'config/application.rb', :after => "Rails::Application" do
  "\n\t\tconfig.generators do |g|\n\t\t\tg.template_engine false\n\t\t\tg.test_framework :test_unit\n\t\t\tg.assets false\n\t\tend\n"
end

git add: "-A"
git commit: '-m "Initialisation du generateur de scaffolding et de la route"'

# transformation de tous les ers en haml
run "rake haml:replace_erbs"
