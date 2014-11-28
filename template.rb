# vars
@appName = @app_name.camelize(:lower)
@AppName = @app_name.camelize(:upper)
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
template "#{filesDir}/app/controllers/home_controller.rb", "app/controllers/home_controller.rb"
git add: "-A"
git commit: '-m "Templating de app/controllers/"'

# app/views/layouts/
template "#{filesDir}/app/views/layouts/application.html.haml.erb", "app/views/layouts/application.html.haml"
FileUtils.rm("app/views/layouts/application.html.erb")
template "#{filesDir}/app/views/layouts/_messages.html.haml", "app/views/layouts/_messages.html.haml"
template "#{filesDir}/app/views/layouts/_navbar.html.haml.erb", "app/views/layouts/_navbar.html.haml"
git add: "-A"
git commit: '-m "Templating de app/views/layouts/"'

# app/views/home
template "#{filesDir}/app/views/home/index.html.haml.erb", "app/views/home/index.html.haml"
git add: "-A"
git commit: '-m "Templating de app/views/home/"'

# config/initializers/
template "#{filesDir}/config/initializers/sprockets.rb", "config/initializers/sprockets.rb"
git add: "-A"
git commit: '-m "Templating de config/initializers/"'

# config/routes.rb
template "#{filesDir}/config/routes.rb", "config/routes.rb"
git add: "-A"
git commit: '-m "Templating de config/routes.rb"'

# config/application.rb
template "#{filesDir}/config/application.rb.erb", "config/application.rb"
git add: "-A"
git commit: '-m "Templating de config/application.rb"'

# app/assets/javascripts/
template "#{filesDir}/app/assets/javascripts/controllers/pages_ctrl.js.coffee.erb", "app/assets/javascripts/controllers/pages_ctrl.js.coffee"
template "#{filesDir}/app/assets/javascripts/controllers/heads_ctrl.js.coffee.erb", "app/assets/javascripts/controllers/heads_ctrl.js.coffee"
template "#{filesDir}/app/assets/javascripts/controllers/flashs_ctrl.js.coffee.erb", "app/assets/javascripts/controllers/flashs_ctrl.js.coffee"
template "#{filesDir}/app/assets/javascripts/services/.keep", "app/assets/javascripts/services/.keep"
template "#{filesDir}/app/assets/javascripts/init.js.coffee.erb", "app/assets/javascripts/init.js.coffee"
template "#{filesDir}/app/assets/javascripts/routes.js.coffee.erb", "app/assets/javascripts/routes.js.coffee"
template "#{filesDir}/app/assets/javascripts/application.js", "app/assets/javascripts/application.js"
git add: "-A"
git commit: '-m "Templating de assets/javascripts/"'

# app/assets/stylesheets
template "#{filesDir}/app/assets/stylesheets/application.css.scss", "app/assets/stylesheets/application.css.scss"
FileUtils.rm("app/assets/stylesheets/application.css")
git add: "-A"
git commit: '-m "Templating de assets/stylesheets/"'

# app/assets/locales/
FileUtils.mkdir_p("app/assets/locales/locales/")
FileUtils.cp("#{filesDir}/app/assets/locales/locales/en.json.erb", "app/assets/locales/locales/en.json.erb")
git add: "-A"
git commit: '-m "Templating de assets/javascripts/"'

# app/services/
template "#{filesDir}/app/services/translations.rb", "app/services/translations.rb"
git add: "-A"
git commit: '-m "Templating de app/services/"'

# app/assets/templates/
template "#{filesDir}/app/assets/templates/pages/index.html.haml.erb", "app/assets/templates/pages/index.html.haml"
git add: "-A"
git commit: '-m "Templating de assets/templates/"'

run "rails generate devise:install"
inject_into_file 'config/environments/development.rb', :after => "config.action_mailer.raise_delivery_errors = false" do
  "\n\tconfig.action_mailer.default_url_options = { host: 'localhost:3000' }"
end
run "rails generate devise User"
rake 'db:migrate'
git add: "-A"
git commit: '-m "Generation du User"'

directory File.expand_path(File.dirname(__FILE__))+"/auth_browserid", "lib/generators/auth_browserid"
git add: "-A"
git commit: '-m "Initialisation du generateur authentification par browserid"'
