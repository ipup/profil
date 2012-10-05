class ExternalLink < ActiveRecord::Base
  # Specifying Relationships 
  belongs_to :user
  
  # Setup accessible (or protected) attributes for the model
  attr_accessible :confidential, :title, :url, :user_id 
  attr_accessible :icon, :icon_cache, :url
  
  # Load the uploader for the icons
  mount_uploader :icon, IconUploader
  
  # Validations :
  #
  # Title should:
  # - exists
  # URL should:
  # - match our regex
  validates_presence_of :title
  validates :url, :format => {
    #Regular expression for a color hexa code: #hhh or #hhhhhh
    :with => /((http:\/\/|https:\/\/)(www.)?(([a-zA-Z0-9\-]){2,}\.){1,4}([a-zA-Z]){2,6}(\/([a-zA-Z\-\_\/\.0-9#:?=&;,]*)?)?)/
  }
end
