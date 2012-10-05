# CUSTOM DEVISE CONTROLLER
#
# Check original/last version here: 
# https://github.com/plataformatec/devise/blob/master/app/controllers/devise/passwords_controller.rb
#
# Reason: Need to implement method 'after_sending_reset_password_instructions_path_for'.
#         Will be in original controller in future version but we needed it now.
class PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])

    if resource.errors.empty?
      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      respond_with resource, :location => after_sending_reset_password_instructions_path_for(resource_name)
    else
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end
  
   protected

    # The path used after sending reset password instructions
    def after_sending_reset_password_instructions_path_for(resource_name)
      root_path
    end
  
end