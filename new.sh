#!/bin/bash
cd ..
rm -Rf test_app
rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle --force
cd test_app
rails g auth_browserid 
rails generate angular_scaffold compte name:string description:text price:decimal rdv:date valid:boolean hour:time create:datetime
