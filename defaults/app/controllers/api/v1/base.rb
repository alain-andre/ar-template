# app/controllers/api/v1/base.rb
# This file must mount all API::V1::xxxxxx
module API
  module V1
    class Base < Grape::API
      # mount API::V1::Objets
    end
  end
end