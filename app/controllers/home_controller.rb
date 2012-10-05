# HOME CONTROLLER :
# Everything related to '/' links.
#
# Our root controller. Control the homepage and some other static page.
class HomeController < ApplicationController  
  # Find the layout in '/views/layouts/homepage.html.erb'
  layout "homepage"
  
  
  # INDEX :
  # The homepage with the subscription & login form
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  #
  # END OF INDEX
  
  
  # NO JS WARNING :
  # The error page for logged user who try to access backend without javascript
  def noJSwarning
    respond_to do |format|
      format.html # noJSwarning.html.erb
    end
  end
  #
  # END OF NO JS WARNING
  
  
  # LEGAL :
  # Static page for our legal notice.
  # Logged user will be provided with a link for destroying all their data.
  def legal
    respond_to do |format|
      format.html # legal.html.erb
    end
  end
  #
  # END OF LEGAL
end
