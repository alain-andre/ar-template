Création d'un générateur de templates pour AngularJS

# Objectif
Générer le code necessaire à l'utilisation de templates dans assets en utilisant le generateur scaffold de rails. 

*Ex: g scaffold CONTROLLER ATTR:type* 

 - Crée le model rails et la migration
 - Crée le js dans assets/javascripts/controllers/CONTROLLER.js
 - Crée le dossier assets/templates/CONTROLLER
 - Crée les fichiers dans assets/templates/CONTROLLER
  - index.html.haml
  - edit.html.haml
  - show.html.haml
  - new.html.haml
  - _form.html.haml
 - ajout dans assets/javascripts/init.js des modules
 - ajout dans assets/javascripts/application.js des routes pour ce module

# Création et ajout du générateur

## La création

```bash
$ rails generate generator angular_template 
  create lib/generators/angular_template 
  create lib/generators/angular_template/angular_template_generator.rb 
  create lib/generators/angular_template/USAGE 
  create lib/generators/angular_template/templates
```

```ruby lib/generators/angular_template_generator.rb 
class AngularTemplateGenerator < Rails::Generators::Base 
  desc "This generator creates a structure for using angularjs templates in assets" 
  def create_initializer_file 
    create_file "config/initializers/initializer.rb", "# Add initialization content here" 
  end 
end
```


## L'ajout du generateur
Modifier `config/application.rb` de façon à ce qu'il ajoute un generateur de templates pour angularjs
```ruby config/application.rb
config.generators do |g| 
  g.orm :active_record 
  g.template_engine :haml 
  g.test_framework :test_unit, :fixture
  g.stylesheets false 
  g.javascripts false 
  g.angularjs :angular_template
end
```