# AUTO GENERATED RAILS CONTROLLER
#
# CRUD Controller for Online CV Fields
# Only new, create, update and delete method
class OnlineCvFieldsController < ApplicationController
  # Devise method for allowing only signed in users.  
  before_filter :authenticate_user!


  # GET /online_cv_fields/new
  def new
    @online_cv_field = OnlineCvField.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  
  # POST /online_cv_fields
  #
  # Redirects to BackEnd Resume path.
  def create
    @online_cv_field = OnlineCvField.new(params[:online_cv_field])

    respond_to do |format|
      if @online_cv_field.save
        format.html { redirect_to(backend_resume_path, :notice => 'Successfully created.') }
      else
        format.html { redirect_to(backend_resume_path, :alert => @online_cv_field.errors.full_messages[0]) }
      end
    end
  end


  # PUT /online_cv_fields/1
  #
  # Redirects to BackEnd Resume path.
  def update
    @online_cv_field = OnlineCvField.find(params[:id])

    respond_to do |format|
      if @online_cv_field.update_attributes(params[:online_cv_field])
        format.html { redirect_to(backend_resume_path, :notice => 'Successfully updated.') }
        format.js { render 'update_lock', :locals => { :form => @online_cv_field } } # Render JS for the confidentiality form call by Ajax
      else
        format.html { redirect_to(backend_resume_path, :alert => @online_cv_field.errors.full_messages[0]) }
      end
    end
  end


  # DELETE /online_cv_fields/1
  #
  # Redirects to BackEnd Resume path.
  def destroy
    @online_cv_field = OnlineCvField.find(params[:id])
    @online_cv_field.destroy

    respond_to do |format|
      format.html { redirect_to(backend_resume_path, :notice => "Field was deleted") }
    end
  end
end
