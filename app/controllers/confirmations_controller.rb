# CUSTOM DEVISE CONTROLLER
#
# Check original/last version here: 
# https://github.com/plataformatec/devise/blob/master/app/controllers/devise/confirmations_controller.rb
#
# Reason: Need to implement method 'after_resending_confirmation_instructions_path_for'.
#         Will be in original controller in future version but we needed it now.
class ConfirmationsController < Devise::ConfirmationsController
  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(params[resource_name])

    if resource.errors.empty?
      set_flash_message(:notice, :send_instructions) if is_navigational_format?
      respond_with resource, :location => after_resending_confirmation_instructions_path_for(resource_name)
    else
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end
  
   protected

    # The path used after resending confirmation instructions.
    def after_resending_confirmation_instructions_path_for(resource_name)
      root_path
    end
  
end