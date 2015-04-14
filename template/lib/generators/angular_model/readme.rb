# Description:
Generate migration and model for the given model attributes.

# Example:

```cmd
  rails generate angular_model Livres nom:string description:text prix:decimal
```

## This will create:
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