class ApplicationController < ActionController::Base

  def mobi_cms_user
    User.find_by_email(cookies.signed[:auth_email])
  end
  helper_method :mobi_cms_user


  def authorized?
    auth_email && User.find_by_email(auth_email)
  end
  helper_method :authorized?

  def auth_email
    cookies.signed[:auth_email].presence
  end
  helper_method :auth_email

  def authorize_user!
    if auth_email && !authorized?
      # authenticated but not authorized
      cookies.signed[:auth_email] = nil
      redirect_to root_url, alert: 'Not Authorized'
    elsif !authorized?
      # protect all controllers (except welcome and session) from unauthorized users
      redirect_to root_url, alert: 'Login First'
    end
  end

  protect_from_forgery
end
