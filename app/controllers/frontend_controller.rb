# FRONTEND CONTROLLER :
# Everything related to '/:domain/' links.
#
# That's the public part of our application. It displays the information of one of our user.
class FrontendController < ApplicationController
  # Find the layout in '/views/layouts/frontend.html.erb'
  # Twitter, Facebook, LinkedIn use 'Social networks'
  # 404 errors (notfound) use its own design (no layouts)
	layout "frontend", :except => [:twitter, :facebook, :linkedin, :notfound]
	
	# Include
	include ActionView::Helpers::DateHelper
	
	# HOME :
  # GET '/:domain/'
  #
  # Homepage of the FrontEnd: Displays the social links of our user.
  # Will respond with '/views/frontend/home.html.erb'
	def home
		@user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
		create_url # Create the correct inner links
		
		respond_to do |format|
      if !@user.nil?
        format.html # home.html.erb
      else    
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
	end
	#
  # END OF HOME
  
  
  # ONLINE RESUME :
  # GET '/:domain/resume'
  #
  # Displays the online resume fields
  # Will respond with '/views/frontend/online_resume.html.erb'
	def online_resume
		@user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
		# We want to order our fields by user's pre-defined preferences (displayorder attributes).
		# Can't just use '@user.online_cv_fields'
		@cv_fields = OnlineCvField.find_all_by_user_id(@user.id, :order => "displayorder")
    create_url # Create the correct inner links
    
    respond_to do |format|
      if !@user.nil?
        format.html # online_resume.html.erb
      else    
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
	end
	#
  # END OF ONLINE RESUME
  
  
  # ABOUT :
  # GET '/:domain/about'
  #
  # Displays the user description (user.user_contents.description)
  # Will respond with '/views/frontend/about.html.erb'
	def about
		@user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
    create_url # Create the correct inner links
    
    respond_to do |format|
      if !@user.nil?
        format.html # about.html.erb
      else    
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
	end
	#
  # END OF ABOUT
  
  
  # CONTACT :
  # GET '/:domain/contact'
  #
  # Online contact form for sending our user a mail
  # Will respond with '/views/frontend/contact.html.erb'
	def contact
    @user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
    @support = Support.new  # Create our Notifier. It's our email sending module.
    create_url # Create the correct inner links
    
    respond_to do |format|
      if !@user.nil?
        format.html # contact.html.erb
      else    
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
	end
	#
  # END OF CONTACT
  
  
  # TWITTER:
  # GET '/:domain/twitter'
  #
  # Our user's twitter feed. Should be display inside a lightbox (colorbox plugin)
  # Can be accessed directly for visitor without JS.
  # Will respond with '/views/frontend/twitter.html.erb'
	def twitter
    @user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL    
    if @user.nil?
      redirect_to notfound_path # Generate 404 error
    end
    
    # TWITTER
    twitter_token = @user.user_content.twitter_token
    twitter_secret = @user.user_content.twitter_secret
    Twitter.configure do |c|
      c.oauth_token = twitter_token
      c.oauth_token_secret = twitter_secret
    end
    @timeline_all = []
    Twitter.user_timeline(:count => 10).each do |tweet|
      d = tweet.created_at.scan(/.{19}/)[0]
      dp = DateTime.parse(d)
      date_tweet = time_ago_in_words(dp)
      @timeline_all.push(date_tweet)
      @timeline_all.push(tweet.text.html_safe)
    end
    @twitter_id = Twitter.user.screen_name
    
    
    respond_to do |format|
      if !@user.nil?
        format.html { render :layout => "social_networks" } 
      else
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
  end
  #
  # END OF TWITTER
  
  
  # FACEBOOK:
  # GET '/:domain/facebook'
  #
  # Our user's facebook feed. Should be display inside a lightbox (colorbox plugin)
  # Can be accessed directly for visitor without JS.
  # Will respond with '/views/frontend/facebook.html.erb'
  def facebook
    @user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
    if @user.nil?
      redirect_to notfound_path # Generate 404 error
    end
    
    # FACEBOOK
    @fb_token = @user.user_content.facebook_token
    if @fb_token
      graph = Koala::Facebook::GraphAPI.new(@fb_token)
      @fb_user = graph.get_object("me")
      @feed = graph.get_connections("me", "feed")
      @fb_timeline = []
      if @feed
        @feed.each do |f|
          if f["from"]["id"] == @fb_user["id"] 
            @fb_timeline.push(f)
          end
        end
      end
    end

    respond_to do |format|
      if !@user.nil?
        format.html { render :layout => "social_networks" } 
      else
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end
  end
  #
  # END OF FACEBOOK
  
  
  # LINKEDIN:
  # GET '/:domain/linkedin'
  #
  # Our user's linkedin feed. Should be display inside a lightbox (colorbox plugin)
  # Can be accessed directly for visitor without JS.
  # Will respond with '/views/frontend/linkedin.html.erb'
  def linkedin
    @user = User.find_by_domain(params[:domain].downcase) # Get our correct user depending on the URL
    if @user.nil?
      redirect_to notfound_path # Generate 404 error
    end
    
    # LINKEDIN    
    # PROFILE
    client = LinkedIn::Client.new(LinkedIn::API_KEY, LinkedIn::SECRET_KEY)
    client.authorize_from_access(@user.user_content.linkedin_token, @user.user_content.linkedin_secret)
    profile = client.profile(:fields => [:id, :first_name, :last_name, :summary, :educations, :positions, :headline])
    @linkedin_id = profile.id
    # NAME
    if profile.respond_to?('first_name')
      @firstName = profile.first_name
    end
    if profile.respond_to?('last_name')
      @lastName = profile.last_name
    end
    # CURRENT STATUS
    if client.respond_to?('current_status')
      @currentStatus = client.current_status
    end
    # EDUCATION - SCHOOL    
    @eduSchool = []
    if profile.respond_to?('educations')
      educations = profile.educations
      educations.each do |e|
        @eduSchool.push(e.school_name)
      end
     # SUMMARY
      if profile.respond_to?('summary')
          @summary = profile.summary
      end
    # POSITIONS
      if profile.respond_to?('positions')
        @positionsFirm = []
        positions = profile.positions
        positions.each do |p|
          if !p.title.nil?
            @positionsFirm.push(p.title)
          end
          if !p.company.name.nil?
            @positionsFirm.push(p.company.name) 
          end              
        end
      end
    # CONNECTIONS
      if client.respond_to?('connections')
        @nb_connections = client.connections.length
      end
    end
    
    respond_to do |format|
      if !@user.nil?
        format.html { render :layout => "social_networks" } 
      else
        format.html { redirect_to notfound_path } # Generate 404 error
      end
    end   
  end
  #
  # END OF LINKEDIN
  
  
  # CHECKCODE:
  # POST 'checkcode'
  # Params:
  # - pid   : user's id
  # - pcode : code posted by the visitor
  #
  # Our privacy function. Will compare visitor's entered code with user's defined code.
  # Will create session and increment code's use counter if code is valid
  # Will display an error message if code is invalid
  # Will respond with redirection to page where user came from
  def checkcode
    # Try to find if our user has create the code entered by our visitor.
    code = InviteCode.where(:user_id => params[:pid],:code => params[:pcode]).first
    
    if !code.nil? # Code valid
      # Increment use counter and saving object
      code.use_counter += 1
      code.save
      
      # Create the session with our user id in it so we know what pages he/she can access.
      # By doing that, we make sure he/she won't access another user's private informations.
      session[:code] =  params[:pid]
      redirect_to(request.referer, :notice => 'Log in successful')
    else # Code invalid
      redirect_to(request.referer, :notice => 'Code not valid.')
    end
  end
  #
  # END OF CHECKCODE
  
  
  # PUBLIC MODE:
  # POST 'public_mode'
  # Params:
  # - pid   : user's id
  #
  # Reserved to logged user on their own page
  # Switch back to the public view by destroying the session
  # Will respond with redirection to page where user came from
  def public_mode
    # We need to destroy the session in order to switch back to public mode
    session[:code] =  nil
    redirect_to(request.referer, :notice => 'Switched to public view')
  end
  #
  # END OF PUBLIC MODE
  
  
  # PRIVATE MODE:
  # POST 'private_mode'
  # Params:
  # - pid   : user's id
  #
  # Reserved to logged user on their own page
  # Switch to the private view by creating the session with his/her id in it
  # Will respond with redirection to page where user came from
  def private_mode
    # Another security - we check again that the user is the owner
    if current_user == User.find(params[:pid])
      # We grant him rights like he would do with a correct code (checkcode)
      session[:code] =  params[:pid]
    end
    redirect_to(request.referer, :notice => 'Switched to private view')
  end
  #
  # END OF PRIVATE MODE
  
  
  
  # NOTFOUND :
  # GET 'notfound'
  #
  # Our custom 404 page
  # Will respond with '/views/frontend/notfound.html.erb'
  def notfound
    respond_to do |format|
      format.html # notfound.html.erb
    end
  end
	#
  # END OF NOT FOUND
  
	protected
	
	# CREATE URL :
	# Create the links that should be use inside the user's frontend
	# Links are being created with the domain attributes
	def create_url
	  @domain_url    = root_url + params[:domain].to_s
	  @resume_url    = @domain_url + "/resume/"
	  @about_url     = @domain_url + "/about/"
	  @contact_url   = @domain_url + "/contact/"
	  @facebook_url  = @domain_url + "/facebook/"
	  @twitter_url   = @domain_url + "/twitter/"
	  @linkedin_url  = @domain_url + "/linkedin/"
	end
	#
  # END OF CREATE URL
end
