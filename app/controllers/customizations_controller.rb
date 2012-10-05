# AUTO GENERATED RAILS CONTROLLER
#
# CRUD Controller for Customizations
# Only new, create, update and delete method
class CustomizationsController < ApplicationController
  # Devise method for allowing only signed in users.
  before_filter :authenticate_user!
  
  
  # GET /customizations/new
  def new
    @customization = Customization.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end
  

  # POST /customizations
  #
  # Redirects to BackEnd Custom path.
  def create
    @customization = Customization.new(params[:customization])

    respond_to do |format|
      if @customization.save
        format.html { redirect_to(backend_custom_path, :notice => 'Successfully created.') }
      else
        # We redirect to BackEnd Custom path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_custom_path, :alert => @customization.errors.full_messages[0]) }
      end
    end
  end


  # PUT /customizations/1
  #
  # Redirects to BackEnd Custom path.
  def update
    @customization = Customization.find(params[:id])

    respond_to do |format|
      if @customization.update_attributes(params[:customization])
        format.html { redirect_to(backend_custom_path, :notice => 'Successfully updated.') }
      else
        # We redirect to BackEnd Custom path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_custom_path, :alert => @customization.errors.full_messages[0]) }
      end
    end
  end
  

  # DELETE /customizations/1
  #
  # Redirects to whatever calls this action.
  def destroy
    @customization = Customization.find(params[:id])
    @customization.destroy

    respond_to do |format|
      format.html { redirect_to(request.referer) }
    end
  end
end
