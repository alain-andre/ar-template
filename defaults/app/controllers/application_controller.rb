class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include JsEnv

  # Define if the current_user is allowed to CRUD.
  def is_admin?
    if current_user
      return true if current_user.is_admin?
    end
  end 
end
