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
    * show.html.haml
    * _form.html.haml
    * admin.html.haml (Only admin allowed)
    * edit.html.haml (Only admin allowed)
    * new.html.haml (Only admin allowed)
  * Creates ruby controller for the view api and admin actions
  * Add the new AngularJS routes in `app/assets/javascripts/routes.js.coffee`
