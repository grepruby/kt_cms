class ApplicationController < ActionController::Base

  def mobi_cms_user
    auth_current_user
  end
  helper_method :mobi_cms_user

  protect_from_forgery
end
