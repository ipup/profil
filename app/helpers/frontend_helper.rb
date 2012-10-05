module FrontendHelper
  # Known_user?
  # Returns a boolean that tells us is the visitor can access private informations
  #
  # Check if the visitor has a session created with the ID in it
  # If the ID corresponds to the user's page one, we grant him/her access
  def known_user?
    if !session[:code].nil?
      if session[:code] == @user.id.to_s
        true
      else
        false
      end
    else
      false
    end
  end
  #
  # END OF KNOWN USER
end
