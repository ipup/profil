# CUSTOM DEVISE CONTROLLER
#
# Check original/last version here: 
# https://github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
#
# Reason: Mostly for choosing what path we want to be redirected to, and having a subscription form on homepage.
class RegistrationsController < Devise::RegistrationsController
  
  def update
    # Devise use update_with_password instead of update_attributes.
    # This is the only change we make.
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      redirect_to after_update_path_for(resource), :flash => { :alert => "All fields can't be blank" }
    end
  end
  
  
  # POST /resource
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        # We delete the session created by an incomplete subscription if it exists.
        if !session[:subscription].nil?
          session[:subscription] = nil
        end
        
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => resource.inactive_message.to_s if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      # Solution for displaying Devise errors on the homepage found on:
      # http://stackoverflow.com/questions/4101641/rails-devise-handling-devise-error-messages
      flash[:notice] = flash[:notice].to_a.concat resource.errors.full_messages
      # We store the invalid object in session so the user hasn't to fill every fields again.
      # The session is deleted if the subscription becomes valid.
      session[:subscription] = resource
      redirect_to root_path
    end
  end
  
  private
  
  # Redirect to the URL after modifying Devise resource (Here, our user)
  def after_update_path_for(resource)
    backend_account_path
  end
  
end