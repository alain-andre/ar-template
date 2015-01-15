# Objective
Make available a project model that allows to generate an AngularJS scaffold

# Example :
`rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle`

Then comes the possibility to insert a browserid authentication :
`rails g auth_browserid`

And the possibility of generating angularjs scaffold of a Thing
`rails generate angular_scaffold Thing` 

# Benefits
  * Use erb and haml in JS files (assets)
  * Use partials in haml templates
  * Using the i18 power for files structure

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/auth_browserid)

# Todo
  * Create the I18 files for the generated angular_scaffold (at least in english)
  * Make the angular_scaffold generator allow offline actions (atm only ping api)
  * Migrate JS files into coffee