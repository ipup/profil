# AUTO GENERATED RAILS CONTROLLER
#
# CRUD Controller for User Contents
# Only new, create, update and delete method
class UserContentsController < ApplicationController
  # Devise method for allowing only signed in users.  
  before_filter :authenticate_user!


  # GET /user_contents/new
  def new
    @user_content = UserContent.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end


  # POST /user_contents
  def create
    @user_content = UserContent.new(params[:user_content])
    select_next_path

    respond_to do |format|
      if @user_content.save
        format.html { redirect_to(@next_path, :notice => 'Successfully created.') }
      else
        format.html { redirect_to(@next_path, :alert => @user_content.errors.full_messages[0]) }
      end
    end
  end


  # PUT /user_contents/1
  def update
    @user_content = UserContent.find(params[:id])
    select_next_path
    
    respond_to do |format|
      if @user_content.update_attributes(params[:user_content])
        format.html { redirect_to(@next_path, :notice => 'Successfully updated.') }
        format.js { render 'update_lock', :locals => { :var_changed => @var_changed.to_s } }
      else
        format.html { redirect_to(@next_path, :alert => @user_content.errors.full_messages[0]) }
      end
    end
  end
  

  # DELETE /user_contents/1
  def destroy
    @user_content = UserContent.find(params[:id])
    @user_content.destroy

    respond_to do |format|
      format.html { redirect_to(request.referer) }
    end
  end
  
  protected
  
  # SELECT NEXT PATH:
  # @next_path :
  # Depending on what attributes are being updated (or created), we set the path we want to redirect to.
  #
  # @var_changed :
  # For Ajax calls from confidentiality form, we also check what attributes has been changed in order to refresh the correct part.
  def select_next_path
    @user_content.attributes = params[:user_content]
    
    if (@user_content.description_changed? || @user_content.description_confidential_changed?)
      @next_path = backend_about_path
      @var_changed = "description"
    elsif (@user_content.file_cv_changed? || @user_content.file_cv_confidential_changed? )
      @next_path = backend_resume_path
      @var_changed = "file_cv"
    elsif (@user_content.twitter_token_changed? ||@user_content.twitter_secret_changed? || @user_content.facebook_token_changed? || @user_content.linkedin_token_changed? || @user_content.linkedin_secret_changed?)
      @next_path = backend_social_path
    else
      @next_path = backend_account_path
      if( @user_content.picture_confidential_changed? )
        @var_changed = "picture"
      elsif( @user_content.info_confidential_changed? )
        @var_changed = "info"
      end
    end    
  end
  #
  # END OF SELECT NEXT PATH
end
