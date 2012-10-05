class Customization < ActiveRecord::Base
  # Specifying Relationships 
  belongs_to :user
  
  # Setup accessible (or protected) attributes for the model
  attr_accessible :user_id
  attr_accessible :color_text_card, :color_bground, :color_lines, :color_text_lines, :color_card, :color_button, :color_title, :color_field_title
  attr_accessible :font_title, :font_card, :font_lines, :font_field_title
  attr_accessible :img_background, :remote_img_background_url, :img_background_cache, :background_mosaic, :remove_img_background
  
  # Gives default values to the model attributes
  after_initialize :init
  
  # Load the uploader for the background
  mount_uploader :img_background, ImgBackgroundUploader
  
  # Validations :
  #
  # Regular expression for a color hexa code: #hhh or #hhhhhh
  COLOR_REGEX = /^\x23([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/
  validates_format_of :color_text_card,   :with => COLOR_REGEX
  validates_format_of :color_bground,     :with => COLOR_REGEX
  validates_format_of :color_lines,       :with => COLOR_REGEX
  validates_format_of :color_text_lines,  :with => COLOR_REGEX
  validates_format_of :color_card,        :with => COLOR_REGEX
  validates_format_of :color_button,      :with => COLOR_REGEX
  validates_format_of :color_title,       :with => COLOR_REGEX
  validates_format_of :color_field_title, :with => COLOR_REGEX
  
  # Other validations are performed directly by Javascript

  def init
    self.color_text_card   ||= "#ffffff"
    self.color_bground     ||= "#49aef5"
    self.color_lines       ||= "#3c759f"
    self.color_text_lines  ||= "#08304d"
    self.color_card        ||= "#3c759f"
    self.color_button      ||= "#08304d"
    self.color_title       ||= "#08304d"
    self.color_field_title ||= "#08304d"
    
    self.background_mosaic ||= false
  end
  
end
