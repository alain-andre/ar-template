# app/controllers/api/v1/defaults.rb
# Concern to use in every class API
module API
  module V1
    module Defaults
      # if you're using Grape outside of Rails, you'll have to use Module#included hook
      extend ActiveSupport::Concern

      included do
        # common Grape settings
        version 'v1' # path-based versioning by default
        format :json # We don't like xml anymore

        # global handler for simple not found case
        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        # global exception handler, used for error notifications
        rescue_from :all do |e|
          if Rails.env.development?
            raise e
          else
            Raven.capture_exception(e)
            error_response(message: "Internal server error", status: 500)
          end
        end

        # HTTP header based authentication
        before do
          error!('Unauthorized', 401) unless headers['Authorization'] == "some token"
        end

        # Define the shared functions like admin! or authenticate!
        helpers do
          def warden
            env['warden']
          end

          def current_user
            warden.user
          end

          # Used to authorize action only to authenticated user
          def authenticate!
            error!('401 Unauthorized', 401) unless current_user
          end

          # Used to authorize action only to authenticated user wich are admins
          def admin!
            error!('401 Unauthorized', 401) unless current_user.is_admin?
          end
        end

      end
    end
  end
end