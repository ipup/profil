class InviteCode < ActiveRecord::Base
  # Specifying Relationships 
  belongs_to :user
  
  # Setup accessible (or protected) attributes for the model
  # By default, every attributes is accessible (No uploader to mount so default values work here)
  
  
  # Validations :
  #
  # Code should:
  # - exists
  # - be unique for each user. (Two users can have the same code, but one user cannot have the same code twice)
  # - be a word between 1 to 15 characters longs (our REGEX)
  # Commentary should:
  # - be a word with 50 characters max (our REGEX)
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :user_id

 
  validates :code, :format => {
    # Regular expression for a string (1 to 15 char. long)
    :with => /^[\w]{1,15}$/
  }
  
  validates :commentary, :format => {
    # Regular expression for a string (0 to 50 char. long)
    :with => /^[\w\s]{0,50}$/
  }
  
end
