class UserContent < ActiveRecord::Base
  # Specifying Relationships 
  belongs_to :user
  
  # Gives default values to the model attributes
  after_initialize :init
  
  # Setup accessible (or protected) attributes for the model
  attr_accessible :picture_confidential, :phone, :address, :info_confidential
  attr_accessible :description, :description_confidential, :file_cv_confidential
  attr_accessible :file_cv, :file_cv_cache, :remove_file_cv, :user_id 
  attr_accessible :twitter_token, :twitter_secret, :facebook_token, :linkedin_token, :linkedin_secret
  attr_accessible :picture, :remote_picture_url, :picture_cache, :remove_picture

  # Load the uploader for the user's picture and user's resume
  mount_uploader :picture, PictureUploader
  mount_uploader :file_cv, FileCvUploader
  
  # Validations :
  #
  # Picture should:
  # - Not be too big.
  validate :picture_size_validation, :if => "picture?"  
  
  def picture_size_validation
    errors[:picture] << "should be less than 1MB" if picture.size > 1.megabytes
  end
  
  
  def init    
    # Default value for confidentiality
    self.picture_confidential     ||= false
    self.info_confidential        ||= false
    self.description_confidential ||= false
    self.file_cv_confidential     ||= false
  end
end
