# Description:
  Generate all the needed stuff to implement BrowserId authentication.

# Example:
```cmd
  rails generate auth_browserid
```

## This will create:
  * Insert/Install the gem devise_browserid_authenticatable
  * Generate browser_id:install
  * Configure Devise for browserid_authenticatable
  * Add browserid javascripts
    * It will create the partial 'layouts/auth_browserid' showing a BrowserId button