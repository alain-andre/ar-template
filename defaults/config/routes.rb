Rails.application.routes.draw do
  root to: 'home#index'

  #Controller api
  mount API::Base => '/api'
end