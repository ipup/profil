class OnlineCvField < ActiveRecord::Base
  # Specifying Relationships 
  belongs_to :user
  
  # Setup accessible (or protected) attributes for the model
  # By default, every attributes is accessible (No uploader to mount so default values work here)
  
  # Gives default values to the model attributes
  after_initialize :init
  
  # Validations :
  #
  # Field name should:
  # - exists
  # Display Order should:
  # - be a number between 1 to 4 digits
  validates_presence_of :field_name
  validates :displayorder, :format => {
    #Regular expression for a number with 1 to 4 digits
    :with => /^[0-9]{1,4}$/
  }
  
  def init
    self.displayorder ||= 1
  end
end
