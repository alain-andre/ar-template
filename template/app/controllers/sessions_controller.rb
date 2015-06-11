class SessionsController < Devise::SessionsController

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    if current_user
      render :json => {:status => true, :role => is_admin?}
    else
      render :json => {:status => false}
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      render :json => {:status => false}
    else
      render :json => {:status => true, :role => is_admin?}
    end
  end

end