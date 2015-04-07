# Objective
[![Code Climate](https://codeclimate.com/github/alain-andre/ar-template/badges/gpa.svg)](https://codeclimate.com/github/alain-andre/ar-template)

This template creates a Rails project working with a server API and a AngularJS application. It comes with a generator that scaffold all the primary files to work (see [Example](#example)).

It is based on [monterail](http://monterail.com/) ideas and a mix of [mines](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/). Once created, the project can generate **angular_scaffold** wich include **migration**, **api**, **controller**, **model** and **CRUD templates**.

CRUD is allowed to only admin users. A **role** is added to [Devise](https://github.com/plataformatec/devise) user and set by default to 0 (lambda) on creation. The `javascripts/routes` will then use the [Rails JS environment](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/) to allow or not access to admin templates.

You can create helpers to define users *role* like this template do for admin users in `application_controller.rb`.

```ruby
# Define if the current_user is allowed to CRUD.
def is_admin?
  if current_user
    return true if current_user.is_admin?
  end
end 
```

## Required
This generator will need the [pg library](https://github.com/alain-andre/ar-template/issues/19). Be sure to have it installed before templating your new project.

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
  * Use generators
  * Use erb and haml in JS files (assets)
  * Use partials in haml templates (assets)
  * Using the I18 power for files structure

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/template/lib/generators/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/template/lib/generators/auth_browserid)

# Testing
This template is using [rspec](https://github.com/rspec/rspec-rails). Run `bundle exec rspec` inside your new generated project to test your generators.

# Documentation
Technical documentation can be generated by running `bundle exec yard`.

If you prefer running yard server do : `bundle exec yard server`.

# License
Copyright (c) 2015 Alain ANDRE. MIT Licensed.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.