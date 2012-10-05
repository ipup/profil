# The most important Model in our application: our USER
#
# The User is managed by Devise plugin
# Find it here: https://github.com/plataformatec/devise
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for the model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :first_name, :pseudo, :domain, :email_confidential
  
  # Validations for our attributes
  #
  # Domain should:
  # - exist
  # - be unique
  # - not conflict with existing routes
  # - match our REGEX.
  #
  # REGEX: Allows letters, numbers and '-' '_' characters. Nothing else. Case insensitive.
  validates_uniqueness_of :domain, :case_sensitive => false
  validates_presence_of :domain
  # Could be improve with something like that:
  # http://stackoverflow.com/questions/6236156/devise-users-have-unique-urls-how-do-i-prevent-them-from-using-controller-actio
  # However, the posted solution didn't work with our project.
  validates_exclusion_of :domain,
                         :in => %w( login logout register notfound backend frontend home noJS users user_contents customizations external_links online_cv_fields invite_codes ),
                         :message => "is already taken."
  validates_format_of :domain, :with => /^([a-zA-Z0-9\-\_]+)$/i 
                  

  # Name, Firstname and Pseudo should:
  # - at least one exist
  validate :any_present?
  # Found on http://stackoverflow.com/questions/2823628/rails-how-to-require-at-least-one-field-not-to-be-blank
  def any_present?
    if %w(name first_name pseudo).all?{|attr| self[attr].blank?}
      errors.add(:base, "Name, First Name and Pseudo can't be all blank")
    end
  end

  # Other validations are managed by Devise itself. Check its configuration file '/config/initializers/devise.rb'

  # Once the model is created, we need to create its (unique) child that are required.
  after_create :create_child
  # Creating child Elements
  def create_child
    UserContent.create("user_id" => id)    
    Customization.create("user_id" => id)
    
    # We use that for initializing default value too
    self.email_confidential = true
    # We save domain in downcase
    self.domain = self.domain.downcase
    self.save
  end
  
  
  # Specifying Relationships  
  has_one  :user_content,     :dependent => :destroy
  has_one  :customization,    :dependent => :destroy
  has_many :external_links,   :dependent => :destroy
  has_many :invite_codes,     :dependent => :destroy
  has_many :online_cv_fields, :dependent => :destroy

end
