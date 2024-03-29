# app/models/support.rb
class Support
  include ActiveModel::Validations

  # Validations :
  validates_presence_of :email, :sender_name, :support_code, :content, :id_to

  # Setup accessible (or protected) attributes for the model
  attr_accessor :id, :email, :sender_name, :support_code, :content, :id_to

  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end 

  def to_key
  end

  def save
    if self.valid?
		  Notifier.support_notification(self).deliver
      return true
    end
    
    return false
  end
end
