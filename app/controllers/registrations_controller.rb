class RegistrationsController < Devise::RegistrationsController
  
protected

  def after_inactive_sign_up_path_for(resource)
    waiting_for_confirmation_path(resource)
  end
end