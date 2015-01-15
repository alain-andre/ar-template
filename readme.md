# Objective
Make available a project model that allows to generate an AngularJS scaffold

# Example :
`rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle`

Then comes the possibility to insert a browserid authentication :
`rails g auth_browserid`

And the possibility of generating angularjs scaffold of a Thing
`rails generate angular_scaffold Thing` 

# Benefits
  * Utiliser erb et haml dans les fichiers JS
  * Rendre des partiels dans les templates haml d'assets
  * Utilisation de la structure i18 pour les fichiers 

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/auth_browserid)

# Todo
  * Put the I18 files into AngularJS translate
  * Make the angular_scaffold generator allow offline actions (atm only ping api)
  * Migrate JS files into coffee