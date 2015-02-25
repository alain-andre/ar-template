require "rubygems"
require "bundler/setup"
require "stringex"

desc "Create a new project called test_app"
task :new do
  `cd ..`
  `rm -Rf test_app`
  `rails _4.0.0_ new test_app -m ar-template/template.rb --skip-bundle --force`
  `cd test_app`
  `rails g auth_browserid`
  `rails generate angular_scaffold compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime`
end