# vars
@appName = @app_name.camelize(:lower)
filesDir = File.expand_path(File.dirname(__FILE__))+"/defaults"

# gem
FileUtils.cp("#{filesDir}/Gemfile", "Gemfile")
git :init
git add: "-A"
git commit: '-m "Définition des gems du projet"'

# lib/
template "#{filesDir}/lib/templates_paths.rb", "lib/templates_paths.rb"
git add: "-A"
git commit: '-m "Templating de lib/"'

# app/controllers/concerns/
template "#{filesDir}/app/controllers/concerns/js_env.rb.erb", "app/controllers/concerns/js_env.rb"
git add: "-A"
git commit: '-m "Templating de app/controllers/concerns/"'

# app/controllers/
template "#{filesDir}/app/controllers/application_controller.rb", "app/controllers/application_controller.rb"
git add: "-A"
git commit: '-m "Templating de app/controllers/"'

# app/views/layouts/
template "#{filesDir}/app/views/layouts/application.html.haml.erb", "app/views/layouts/application.html.haml"
FileUtils.rm("app/views/layouts/application.html.erb")
template "#{filesDir}/app/views/layouts/_messages.html.haml", "app/views/layouts/_messages.html.haml"
template "#{filesDir}/app/views/layouts/_navbar.html.haml.erb", "app/views/layouts/_navbar.html.haml"
git add: "-A"
git commit: '-m "Templating de app/views/layouts/"'

# config/initializers/
template "#{filesDir}/config/initializers/sprockets.rb", "config/initializers/sprockets.rb"
git add: "-A"
git commit: '-m "Templating de config/initializers/"'


# app/assets/javascripts/
template "#{filesDir}/app/assets/javascripts/controllers/pages_ctrl.js.coffee.erb", "app/assets/javascripts/controllers/pages_ctrl.js.coffee"
FileUtils.mkdir_p("app/assets/javascripts/locales/locales/")
FileUtils.cp("#{filesDir}/app/assets/javascripts/locales/locales/en.json.erb", "app/assets/javascripts/locales/locales/en.json.erb")
template "#{filesDir}/app/assets/javascripts/init.js.coffee.erb", "app/assets/javascripts/init.js.coffee"
template "#{filesDir}/app/assets/javascripts/application.js", "app/assets/javascripts/application.js"
git add: "-A"
git commit: '-m "Templating de config/initializers/"'

# ======================================
# inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
#   "\n//= require angular-ui-bootstrap"
# end

# inject_into_file 'app/assets/stylesheets/application.css', :after => "*/" do
#   "\n\n@import \"bootstrap.css\";"
# end

# git add: "-A"
# git commit: '-m "Configuration du css bootstrap pour angular"'

# inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
#   "\n//= require angular-ujs"
# end
# gsub_file 'app/assets/javascripts/application.js', /\/\/= require jquery/, "//"
# gsub_file 'app/assets/javascripts/application.js', /\/\/_ujs/, "//"

# #
# say "Configuration de l'application angularjs"
# gsub_file 'app/views/layouts/application.html.erb', /<html>/, "<html lang=\"fr\" ng-app=\"#{@appName}\">"

# File.new("app/assets/javascripts/init.js", "w")
# append_to_file 'app/assets/javascripts/init.js' do
#   "'use strict';\n\t// initialisation de l'application\n\tvar #{@appName} = angular.module('#{@appName}', ['ngRoute', 'angular.ujs']);"
# end

# inject_into_file 'app/assets/javascripts/application.js', :before => "//= require_tree ." do
#   "\n//= require init\n"
# end

# git add: "-A"
# git commit: '-m "Configuration des scripts pour angular"'

# run "rails generate devise:install"
# inject_into_file 'config/environments/development.rb', :after => "config.action_mailer.raise_delivery_errors = false" do
#   "\n\tconfig.action_mailer.default_url_options = { host: 'localhost:3000' }"
# end

# inject_into_file 'app/controllers/application_controller.rb', :after => "protect_from_forgery with: :exception" do
#   "\n\tbefore_filter :authenticate_user!"
# end

# run "rails generate devise User"
# rake 'db:migrate'

# directory File.expand_path(File.dirname(__FILE__))+"/defaults/devise", "app/views/devise"

# inject_into_file 'config/application.rb', :after => "# config.i18n.default_locale = :de" do
#   "\n\t\tconfig.i18n.default_locale = :fr\n"
# end

# git add: "-A"
# git commit: '-m "Generation de User et devise:views + internationalisation"'

# file = File.open(File.expand_path(File.dirname(__FILE__))+"/defaults/application_yield", "rb")
# gsub_file 'app/views/layouts/application.html.erb', /<%= yield %>/, file.read
# gsub_file 'app/views/layouts/application.html.erb', /app_name/, "#{@appName}"

# git add: "-A"
# git commit: '-m "Ajout de la barre menu + messages dans app/views/layouts/application.html.erb"'

# #
# say "Création de l'architecture pour la gestion des templates angularjs"
# file = File.open(File.expand_path(File.dirname(__FILE__))+"/defaults/application_js", "rb")
# inject_into_file 'app/assets/javascripts/application.js', :after => "//= require_tree ." do
#   "\n\n"+file.read
# end
# gsub_file 'app/assets/javascripts/application.js', /app_name/, "#{@appName}"

# #
# say "Ajout du dossier templates dans la configuration assets"
# inject_into_file 'config/application.rb', :after => "Rails::Application" do
#   "\n\t\tconfig.assets.paths << Rails.root.join('app', 'assets', 'templates')"
# end

# #
# say "Prise en compte du HAML dans assets"
# File.new("config/initializers/haml.rb", "w")
# append_to_file 'config/initializers/haml.rb' do
#   "\nRails.application.assets.register_engine '.haml', Tilt::HamlTemplate"
# end
# say "Mise en place de la gestion des partials dans les Haml d'Assets"
# append_to_file 'config/initializers/haml.rb' do
#   "\nRails.application.assets.context_class.class_eval do\n\tinclude HamlHelper\n\tend"
# end
# template File.expand_path(File.dirname(__FILE__))+"/defaults/haml_helper.rb.erb", "app/helpers/haml_helper.rb" 

# git add: "-A"
# git commit: '-m "Création de l\'architecture pour la gestion des templates angularjs"'

# #
# say "Initialisation du generateur de scaffolding"
# directory File.expand_path(File.dirname(__FILE__))+"/angular_template", "lib/generators/angular_template"

# run "rails g controller home index --skip-assets"
# File.write('app/views/home/index.html.erb', "\n<div ng-view></div>")

# gsub_file 'config/routes.rb', /# root 'welcome#index'/, "root 'home#index'"

# # Modification des generateurs
# inject_into_file 'config/application.rb', :after => "Rails::Application" do
#   "\n\t\tconfig.generators do |g|\n\t\t\tg.template_engine false\n\t\t\tg.test_framework :test_unit\n\t\t\tg.assets false\n\t\tend\n"
# end

# git add: "-A"
# git commit: '-m "Initialisation du generateur de scaffolding et de la route"'

# # transformation de tous les ers en haml
# run "rake haml:replace_erbs"
