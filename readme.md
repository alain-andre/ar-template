# Objective
[![Code Climate](https://codeclimate.com/github/alain-andre/ar-template/badges/gpa.svg)](https://codeclimate.com/github/alain-andre/ar-template)
[![Test Coverage](https://codeclimate.com/github/alain-andre/ar-template/badges/coverage.svg)](https://codeclimate.com/github/alain-andre/ar-template)

This template creates a Rails project working with a server API and a AngularJS application. It comes with a generator that scaffold all the primary files to work (see [Example](#example)).

It is based on [monterail](http://monterail.com/) ideas and a mix of [mines](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/). Once created, the project can generate **angular_scaffold** wich include **migration**, **api**, **controller**, **model** and **CRUD templates**.

CRUD is allowed to only admin users. A **role** is added to [Devise](https://github.com/plataformatec/devise) user and set by default to 0 (lambda) on creation. The `javascripts/routes` will then use the [Rails JS environment](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/) to allow or not access to admin templates.

# Example
Use the rakefile to generate a new project :
`bundle exec rake new_app['new_project']`

You will have the following options :
 * Generate rspec installation?
 * Add devise gem amd configure it?
  * Add role to the user model?
  * Add browserid authentication?
 * Generate angular scaffolding?
  * What is the Object name to scaffold?
  * What's the structure of the object? (describe it like a model generation)

# Benefits
  * Use erb and haml in JS files (assets)
  * Use partials in haml templates
  * Using the i18 power for files structure
  * Use generators

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/template/lib/generators/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/template/lib/generators/auth_browserid)

# Testing
This template is using [rspec](https://github.com/rspec/rspec-rails). Run `bundle exec rspec` inside your new generated project to test your generators.

# Todo
  * Make the angular_scaffold generator allow offline actions (atm only ping api)
  * Migrate JS files into coffee

# License

Copyright (c) 2015 Alain ANDRE. MIT Licensed.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.