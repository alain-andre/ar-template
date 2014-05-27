#!/bin/bash
rm -Rf test_app
rails _4.0.0_ new test_app -m template.rb --skip-bundle
