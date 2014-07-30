#!/bin/bash
rm -Rf test_app
rails _4.0.0_ new test_app -m template.rb --skip-bundle
cd test_app
rails g angular_template book