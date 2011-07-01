class ApplicationController < ActionController::Base
  protect_from_forgery

  filter_parameter_logging :card_number, :card_verification_value, :card_expires

  def after_sign_in_path_for(resource_or_scope)
    "/"
  end
end
