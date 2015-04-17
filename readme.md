# Objective
[![Code Climate](https://codeclimate.com/github/alain-andre/ar-template/badges/gpa.svg)](https://codeclimate.com/github/alain-andre/ar-template)

This template creates a Rails project working with a server API and a AngularJS application. It comes with a generator that scaffold all the primary files to work (see [Example](#example)).

It is based on [monterail](http://monterail.com/) ideas and a mix of [mines](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/). Once created, the project can generate **angular_scaffold** wich include **migration**, **api**, **controller**, **model** and **CRUD templates**.

CUD is allowed to only admin users. A **role** is added to [Devise](https://github.com/plataformatec/devise) user and set by default to 0 (lambda) on creation. The `javascripts/routes` will then use the [Rails JS environment](http://www.alain-andre.fr/blog/2015/01/23/configurer-rails-avec-angularjs/) to allow or not access to admin templates.

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
This generator will need the [pg dev library](https://github.com/alain-andre/ar-template/issues/19) and the sqlite dev library (libsqlite3-dev for debian based). Be sure to have it installed before templating your new project.

## How it works
First of all, the `templates` function of `lib/templates_paths.rb` list all the files to work with AngularJS. It is then used in the `app/controllers/concerns/js_env.rb` concern that creates an AngularJS module called **share** and is inserted in the `application.html` file of the project.

This way, it is possible to pass a lot of rails informations to the AngularJS application like the liste of templates, the rails environement etc.

### The browserid authentication
A generator called `auth_browserid` is abble to automatically implement the project with a [BrowserID](http://login.persona.org) authentication.

**Example:**

```cmd
  bundle exec rails generate auth_browserid
```

**This will create:**

-app/assets/javascripts/controllers
 - browserid_ctrl.js.coffee (The implementation of the Browserid into the project).
-app/views/layouts
 - _auth.html.haml (Override the project partial to render the `auth_browserid` partial).
 - _auth_browserid.html.haml (Handle the loggin buttons).

### Create a model
Generate migration and model for the given model attributes.

**Example:**

```cmd
  bundle exec rails generate angular_model Livres nom:string description:text prix:decimal
```

**This will create:**

A migration that will be automatically migrate.

```ruby 
# db/migrate/20150411095016_create_livres.rb
class CreateLivres < ActiveRecord::Migration
  def self.up
    create_table :livres do |t|
      t.string :nom
      t.text :description
      t.decimal :prix
    
      t.timestamps
    end
  end

  def self.down
    drop_table :livres
  end
end
```

And an empty model.

```ruby
# app/models/livres.rb
class Livres < ActiveRecord::Base
  # This Class is composed of nom (:string), description (:text), prix (:decimal)
end
```

### Create a view
Generate all the needed views.

**Example:**

```cmd
  bundle exec rails generate angular_views Livres nom:string description:text prix:decimal
```

This will create the following files :
- app/assets/templates
 - _filter.html.haml (A partial called to filter the list of *Livres*).
 - _form.html.haml (The form partial containing all the needed front tests like *max-length*, *min-length* etc.).
 - admin.html.haml (Rendering th list of *Livres* with the admin options allowing CUD).
 - edit.html.haml (Rendering the form with the *edit* options).
 - index.html.haml (The list of *Livres* filters options).
 - new.html.haml (Rendering the form with the *new* options).
 - show.html.haml (The list of the attributes of a selected *Livre*).
- config/locales
 - en.rb (All the key:values needed by the views).

### Create a controller
Generate all the controllers and services to allow JS communicate with the CRUD API.

**Example:**

```cmd
  bundle exec rails generate angular_controller Livres nom:string description:text prix:decimal
```

This will create the following files :
 - app/assets/javascripts
  - controller.js (It contains all the needed AngularJS controllers to comunicate with the CRUD API).
  - service.js (Handle the AngularJS $resource).
 - app/controllers/api/v1
  - controller.rb (Grape::API controller managing the CRUD).

### Scaffolding
Generate model, views and controller for the given arguments.

**Example:**

```cmd
  bundle exec rails generate angular_scaffold Livres nom:string description:text prix:decimal
```

# Example
Use the rakefile to generate a new project; if no project name is given, the rakefile will create a project called `new_app`.

**Use:**

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
