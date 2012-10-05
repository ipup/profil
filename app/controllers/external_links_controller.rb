# AUTO GENERATED RAILS CONTROLLER
#
# CRUD Controller for External Links
# Only new, create, update and delete method
class ExternalLinksController < ApplicationController
  # Devise method for allowing only signed in users.
  before_filter :authenticate_user!

  # GET /external_links/new
  def new
    @external_link = ExternalLink.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end


  # POST /external_links
  #
  # Redirects to BackEnd Social path.
  def create
    @external_link = ExternalLink.new(params[:external_link])

    respond_to do |format|
      if @external_link.save
        format.html { redirect_to(backend_social_path, :notice => 'Successfully created.') }
      else
        # We redirect to BackEnd Social path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_social_path, :alert => @external_link.errors.full_messages[0]) }
      end
    end
  end
  

  # PUT /external_links/1
  #
  # Redirects to BackEnd Social path.
  def update
    @external_link = ExternalLink.find(params[:id])

    respond_to do |format|
      if @external_link.update_attributes(params[:external_link])
        format.html { redirect_to(backend_social_path, :notice => 'Successfully updated.') }
        format.js { render 'update_lock', :locals => { :link => @external_link } } # Render JS for the confidentiality form call by Ajax
      else
        # We redirect to BackEnd Social path with only the first error in the alert.
        # If many errors happens, only the first one is displayed.
        format.html { redirect_to(backend_social_path, :alert => @external_link.errors.full_messages[0]) }
      end
    end
  end
  

  # DELETE /external_links/1
  #
  # Redirects to BackEnd Social path.
  def destroy
    @external_link = ExternalLink.find(params[:id])
    @external_link.destroy

    respond_to do |format|
      format.html { redirect_to(backend_social_path) }
    end
  end
end
