# Description:
Generate a angularjs scaffold for the given arguments.

# Example:

```cmd
  rails generate angular_scaffold thing name:string description:text price:decimal
```

## This will create:
  * Creates the AngularJS controller in `assets/javascripts/controllers/`
  * Creates files in assets/templates/#{class_name}
    * index.html.haml
    * edit.html.haml
    * show.html.haml
    * new.html.haml
    * _form.html.haml
  * Creates ruby controller for the view api and admin actions
  * Add the new AngularJS routes in `app/assets/javascripts/routes.js.coffee`
