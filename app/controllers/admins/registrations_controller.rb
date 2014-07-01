class Admins::RegistrationsController < Devise::RegistrationsController
skip_before_filter :require_no_authentication
before_filter :authenticate_admin!, :redirect_unless_admin

private

  def redirect_unless_admin
    unless current_admin
      redirect_to root_path
    end
  end
end
