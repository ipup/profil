module BackendHelper
  # LOCK IMG HELPER:
  # Returns an image path
  #
  # Take a boolean as parameters and returns an open or close lock image depending on boolean value.
  def lock_img(resource)
    if resource == true
      return "/images/padlock_locked.png"
    else
      return "/images/padlock_unlocked.png"
    end    
  end
  #
  # END OF LOCK IMG HELPER
  
  
  # OPPOSITE VALUE
  # Take a boolean as parameters and returns the opposite value  
  def opposite_value(resource)
    if resource == true
      return false
    else
      return true
    end
  end
  #
  # END OF OPPPOSITE VALUE
end
