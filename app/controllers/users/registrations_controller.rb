class Users::RegistrationsController < Devise::RegistrationsController

  def update
    super do |resource|
      resource.slug = nil
      resource.save!
    end
  end
end
