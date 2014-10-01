module Mercury
  module Authentication

    def can_edit?
      if :authenticate_user! && current_user?(@user)
        true # check here to see if the user is logged in/has access
      else
        redirect_to root_path
      end
    end

  end
end
