# AUTO GENERATED RAILS CONTROLLER
#
# CRUD Controller for Invite Codes
# Only new, create, update and delete method
class InviteCodesController < ApplicationController
  # Devise method for allowing only signed in users.
  before_filter :authenticate_user!
 
 
  # GET /invite_codes/new
  def new
    @invite_code = InviteCode.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end


  # POST /invite_codes
  #
  # Redirects to BackEnd Privacy path.
  def create
    @invite_code = InviteCode.new(params[:invite_code])

    respond_to do |format|
      if @invite_code.save
        format.html { redirect_to(backend_privacy_path, :notice => 'Successfully created.') }
      else
        # We redirect to BackEnd Privacy path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_privacy_path, :alert => @invite_code.errors.full_messages[0] ) }
      end
    end
  end
  

  # PUT /invite_codes/1
  #
  # Redirects to BackEnd Privacy path.
  def update
    @invite_code = InviteCode.find(params[:id])

    respond_to do |format|
      if @invite_code.update_attributes(params[:invite_code])
        format.html { redirect_to(backend_privacy_path, :notice => 'Successfully updated.') }
      else
        # We redirect to BackEnd Privacy path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_privacy_path, :alert => @invite_code.errors.full_messages[0] ) }
      end
    end
  end
  

  # DELETE /invite_codes/1
  # DELETE /invite_codes/1.xml
  #
  # Redirects to BackEnd Privacy path.
  def destroy
    @invite_code = InviteCode.find(params[:id])
    @invite_code.destroy

    respond_to do |format|
      format.html { redirect_to(backend_privacy_path, :alert => "Url was deleted") }
    end
  end
end
