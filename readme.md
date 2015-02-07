# Objective
[![Code Climate](https://codeclimate.com/github/alain-andre/ar-template/badges/gpa.svg)](https://codeclimate.com/github/alain-andre/ar-template)
[![Test Coverage](https://codeclimate.com/github/alain-andre/ar-template/badges/coverage.svg)](https://codeclimate.com/github/alain-andre/ar-template)

Creates a project that allows to generate an AngularJS scaffold. The project template configure Rails with AngularJS based on [monterail](http://monterail.com/) idea and a mix of my [ideas](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/). Once created, the project can generate **angular_scaffold** wich include **migration**, **api**, **controller**, **model** and **CRUD templates**.

CRUD is allowed to only admin users. A **role** is added to [Devise](https://github.com/plataformatec/devise) user and set by default to 0 (lambda) on creation. The `javascripts/routes` will then use the [Rails JS environment](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/) to allow or not access to admin templates.

# Example :
`rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle`

Then comes the possibility to insert a browserid authentication :
`rails g auth_browserid`

And the possibility of generating angularjs scaffold of a Thing with ts composition
`rails generate angular_scaffold thing name:string description:text price:decimal` 

# Benefits
  * Use erb and haml in JS files (assets)
  * Use partials in haml templates
  * Using the i18 power for files structure

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/auth_browserid)

# Todo
  * Make the angular_scaffold generator allow offline actions (atm only ping api)
  * Migrate JS files into coffee