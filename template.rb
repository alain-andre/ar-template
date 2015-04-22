# vars
@appName = @app_name.camelize(:lower)
@AppName = @app_name.camelize(:upper)
filesDir = File.expand_path(File.dirname(__FILE__))+"/template"

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
template "#{filesDir}/app/controllers/api/base.rb", "app/controllers/api/base.rb"
template "#{filesDir}/app/controllers/api/v1/base.rb", "app/controllers/api/v1/base.rb"
template "#{filesDir}/app/controllers/api/v1/defaults.rb", "app/controllers/api/v1/defaults.rb"
git add: "-A"
git commit: '-m "Templating de app/controllers/"'

# app/views/layouts/
template "#{filesDir}/app/views/layouts/application.html.haml.erb", "app/views/layouts/application.html.haml"
FileUtils.rm("app/views/layouts/application.html.erb")
template "#{filesDir}/app/views/layouts/_auth.html.haml", "app/views/layouts/_auth.html.haml"
template "#{filesDir}/app/views/layouts/_messages.html.haml", "app/views/layouts/_messages.html.haml"
template "#{filesDir}/app/views/layouts/_navbar.html.haml.erb", "app/views/layouts/_navbar.html.haml"
template "#{filesDir}/app/views/layouts/_menu.html.haml", "app/views/layouts/_menu.html.haml"
git add: "-A"
git commit: '-m "Templating de app/views/layouts/"'

# app/views/home
template "#{filesDir}/app/views/home/index.html.haml.erb", "app/views/home/index.html.haml"
git add: "-A"
git commit: '-m "Templating de app/views/home/"'

# config/initializers/
template "#{filesDir}/config/initializers/sprockets.rb", "config/initializers/sprockets.rb"
template "#{filesDir}/config/initializers/haml.rb", "config/initializers/haml.rb"
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
git commit: '-m "Templating de app/assets/templates/"'

# app/helpers/
template "#{filesDir}/app/helpers/haml_helper.rb", "app/helpers/haml_helper.rb"
git add: "-A"
git commit: '-m "Templating de app/helpers/"'

# GENERATORS
directory "#{filesDir}/app/models/concerns", "app/models/concerns"

directory "#{filesDir}/lib/generators/auth_browserid", "lib/generators/auth_browserid"
template "#{filesDir}/spec/generators/auth_browserid_generator_spec.rb", "spec/generators/auth_browserid_generator_spec.rb"
git add: "-A"
git commit: '-m "Copie du generateur authentification par browserid"'

directory "#{filesDir}/lib/generators/angular_controller", "lib/generators/angular_controller"
#template "#{filesDir}/spec/generators/angular_controller_generator_spec.rb", "spec/generators/angular_controller_generator_spec.rb"
git add: "-A"
git commit: '-m "Copie du generateur de controller AngularJS"'

directory "#{filesDir}/lib/generators/angular_model", "lib/generators/angular_model"
#template "#{filesDir}/spec/generators/angular_model_generator_spec.rb", "spec/generators/angular_model_generator_spec.rb"
git add: "-A"
git commit: '-m "Copie du generateur de model AngularJS"'

directory "#{filesDir}/lib/generators/angular_views", "lib/generators/angular_views"
#template "#{filesDir}/spec/generators/angular_views_generator_spec.rb", "spec/generators/angular_views_generator_spec.rb"
git add: "-A"
git commit: '-m "Copie du generateur de views AngularJS"'

directory "#{filesDir}/lib/generators/angular_scaffold", "lib/generators/angular_scaffold"
template "#{filesDir}/spec/generators/angular_scaffold_generator_spec.rb", "spec/generators/angular_scaffold_generator_spec.rb"
git add: "-A"
git commit: '-m "Copie du generateur de scaffold AngularJS"'
