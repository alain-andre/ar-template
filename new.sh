#!/bin/bash
cd ..
rm -Rf test_app
rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle
# cd test_app
# rails g angular_template test_book
# rails g model test_book nom:string:uniq appellation:string couleur:string 'price:decimal{10,2}'
# bundle exec rake db:migrate
