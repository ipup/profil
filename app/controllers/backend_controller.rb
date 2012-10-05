# BACKEND CONTROLLER :
# Everything related to '/backend/' links.
#
# Only Devise logged User (with Javascript enabled) can access it
# User can edit and create everything related to his account on the backend.
class BackendController < ApplicationController
  # Devise method for allowing only signed in users.
  before_filter :authenticate_user!
  
  # Find the layout in '/views/layouts/backend.html.erb'
  layout "backend"
  
  
  # ACCOUNT :
  # GET '/backend/account', GET '/backend/'
  #
  # User can edit his personnal information and complete others infos (such as Phone, Mail)
  # Will respond with '/views/backend/account.html.erb'
  # Layout will be removed if the request is made by Ajax
  def account
    # We find 'User' and 'Users Content' objects related to the signed in user
    @user    = current_user
    @content = UserContent.find_by_user_id(@user.id) # Originally created on 'User' creation. Check 'User' Model.
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # account.html.erb
      else
        format.html # account.html.erb WITH layout
      end
    end
  end
  #
  # END OF ACCOUNT
  
  
  # RESUME :
  # GET '/backend/resume'
  #
  # User can upload his CV or edit/create 'Online CV Fields' objects.
  # Will respond with '/views/backend/resume.html.erb'
  # Layout will be removed if the request is made by Ajax  
  def resume
    @user             = current_user
    # Get all privously existing fields, ordering them by the attribute 'displayorder' (integer)
    @online_cv_fields = OnlineCvField.find_all_by_user_id(@user.id, :order => "displayorder")
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # resume.html.erb
      else
        format.html # resume.html.erb WITH layout
      end
    end
  end
  #
  # END OF RESUME
  
  
  # PRIVACY :
  # GET '/backend/privacy'
  #
  # User can upload his CV or edit/create 'Online CV Fields' objects.
  # Will respond with '/views/backend/resume.html.erb'
  # Layout will be removed if the request is made by Ajax
  def privacy
    @user       = current_user
    @code       = InviteCode.new # Used if the user uses the POST form
    @guestcodes = @user.invite_codes # All previously existing codes
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # privacy.html.erb
      else
        format.html # privacy.html.erb WITH layout
      end
    end
  end
  #
  # END OF PRIVACY
  
  
  # ABOUT :
  # GET '/backend/about'
  #
  # User edits his description and its confidentiality
  # Will respond with '/views/backend/about.html.erb'
  # Layout will be removed if the request is made by Ajax
  def about
    @user    = current_user
    @content = UserContent.find_by_user_id(@user.id) # Originally created on 'User' creation. Check 'User' Model.
    # @content = current_user.user_contents
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # about.html.erb
      else
        format.html # about.html.erb WITH layout
      end
    end
  end
  #
  # END OF ABOUT
  
  
  # CUSTOM :
  # GET '/backend/custom'
  #
  # User chooses a theme and can customize it (Color, fonts and background image)
  # Will respond with '/views/backend/custom.html.erb'
  # Layout will be removed if the request is made by Ajax
  def custom
    @user   = current_user
    @custom = Customization.find_by_user_id(@user.id) # Originally created on 'User' creation. Check 'User' Model.    
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # custom.html.erb
      else
        format.html # custom.html.erb WITH layout
      end
    end    
  end
  #
  # END OF CUSTOM  
  
  
  # SOCIAL :
  # GET '/backend/social'
  #
  # User can linked his social networks (Twitter, Facebook, LinkedIn) and add/delete others links
  # Will respond with '/views/backend/social.html.erb'
  # Layout will be removed if the request is made by Ajax
  def social
    @user  = current_user
    @links = current_user.external_links
    
    # TWITTER
    if @user.user_content.twitter_token.blank?
      clientTwitter = TwitterOAuth::Client.new(:consumer_key => TwitterEnv::API_KEY, :consumer_secret => TwitterEnv::SECRET_KEY)
      request_token = clientTwitter.request_token(:oauth_callback => TwitterEnv::CALLBACK_URL)    
      session[:rtoken_twitter] = request_token.token
      session[:rsecret_twitter] = request_token.secret
      @login_twitter_url = request_token.authorize_url
    end
    
    # FACEBOOK
    @login_facebook_url = Koala::Facebook::OAuth.new.url_for_oauth_code(:permissions => 'read_stream,offline_access')
    
    if params[:code]
      @user.user_content.facebook_token = Koala::Facebook::OAuth.new.get_access_token(params[:code])
      @user.user_content.save
    end
    
    # LINKEDIN
    if params[:oauth_verifier]
      client = LinkedIn::Client.new(LinkedIn::API_KEY, LinkedIn::SECRET_KEY)
      if @user.user_content.linkedin_token.blank?
        pin = params[:oauth_verifier]
        atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
        @user.user_content.linkedin_token = atoken
        @user.user_content.linkedin_secret = asecret
        @user.user_content.save
      else
        client.authorize_from_access(@user.user_content.linkedin_token, @user.user_content.linkedin_secret)
      end
    else
      client = LinkedIn::Client.new(LinkedIn::API_KEY, LinkedIn::SECRET_KEY)
      request_token = client.request_token(:oauth_callback => LinkedIn::CALLBACK_URL)
      session[:rtoken] = request_token.token
      session[:rsecret] = request_token.secret
      @login_linkedin_url = client.request_token.authorize_url
    end
    
    respond_to do |format|      
      if params[:ajax] == "true" # Request came from ajax. Respond without layout.
        format.html { render :layout => false } # social.html.erb
      else
        format.html # social.html.erb WITH layout
      end
    end
  end
  #
  # END OF SOCIAL
  
  
  # TWITTER :
  # GET '/backend/twitter'
  #
  # Callback page for Twitter authentification. Invisible to the user.
  # Redirects to BackEnd Social
  def twitter
    @user = current_user
    if params[:oauth_verifier]
      if @user.user_content.twitter_token.blank?
        clientTwitter = TwitterOAuth::Client.new(:consumer_key => TwitterEnv::API_KEY, :consumer_secret => TwitterEnv::SECRET_KEY)
        pin = params[:oauth_verifier]
        access_token = clientTwitter.authorize(session[:rtoken_twitter], session[:rsecret_twitter], :oauth_verifier => pin)
        @user.user_content.twitter_token = access_token.token
        @user.user_content.twitter_secret = access_token.secret
        @user.user_content.save
      else
        clientTwitter = TwitterOAuth::Client.new(
          :consumer_key => TwitterEnv::API_KEY,
          :consumer_secret => TwitterEnv::SECRET_KEY,
          :token => @user.user_content.twitter_token, 
          :secret => @user.user_content.twitter_secret)
      end
    end
    
    redirect_to "/backend/social"
  end
  #
  # END OF TWITTER
end
