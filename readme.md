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

# Example
## Rakefile 
Generate a new project called *my_project* using the template :

`rake new_project[my_project]`

You will have then the following options :
* skip devise installation
* generate a auth_browserid # Insert a browserid authentication
* generate a angular_scaffold # Generate an angularjs scaffold example

## command line
Generate a new project called *test_app* using the template :

`rails _4.0.0_ new test_app -m ar-template/template.rb`

You can use `--skip-devise` option if you don't need Users.

`rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle --skip-devise`

Insert a browserid authentication :

`rails g auth_browserid`

Generate an angularjs scaffold of a *Thing* with its composition (Define it like you should for a model) :

`rails generate angular_scaffold thing name:string description:text price:decimal` 

# Benefits
  * Use generators
  * Use erb and haml in JS files (assets)
  * Use partials in haml templates (assets)
  * Using the I18 power for files structure

# Generators
  * [angular_scaffold](https://github.com/alain-andre/ar-template/tree/master/angular_scaffold)
  * [auth_browserid](https://github.com/alain-andre/ar-template/tree/master/auth_browserid)

# Testing
This template is using [ammeter](https://github.com/alexrothenberg/ammeter) to rspec the generators. Run `bundle exec rspec` to test them.


# License

Copyright (c) 2015 Alain ANDRE. MIT Licensed.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.