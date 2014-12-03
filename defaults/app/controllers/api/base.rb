# app/controllers/api/base.rb
# This file must mount all the API::Vx::Base classes
module API
  class Base < Grape::API
    mount API::V1::Base
  end
end