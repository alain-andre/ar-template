#!/bin/bash
cd ..
rm -Rf test_app
rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle
cd test_app
rails g auth_browserid
