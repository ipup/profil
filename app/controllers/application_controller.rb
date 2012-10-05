class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private

  # Overwriting the sign_out redirect path method (Devise method)
  def after_sign_in_path_for(resource_or_scope)
    backend_path
  end

end
