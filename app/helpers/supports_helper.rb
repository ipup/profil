module SupportsHelper
  # ID TO MAIL :
  # In order to protect our user's mail address, we don't display in the source code his address
  # Instead we take his/her ID and find the appropriate email
  # This function returns that email
  def id_to_mail(id_to)
    email = User.find(id_to).email
    if !email.nil?
      return email
    end
  end
  #
  # END OF ID TO MAIL
end
