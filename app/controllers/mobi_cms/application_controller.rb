require 'cancan'
module MobiCms
  class MobiCms::ApplicationController < ApplicationController
    before_filter :conf_authenticate_option

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to mobi_cms.root_path, :alert => exception.message
    end

    def current_ability
      MobiCms::Ability.new(mobi_cms_user)
    end


  private


  def cms_layout
    if auth_email.blank?
      "layouts/mobi_cms/public" 
    else
      "layouts/mobi_cms/profile" 
    end
  end

  def conf_admin_option
    if (defined? MobiCms.admin_user) and MobiCms.admin_user.present?
      send MobiCms.admin_user
    else
      raise " You'll need to define a 'admin_user' method for MobiCms to validate a user as a admin role. You can set MobiCms.admin_user in config/initializers/mobi_cms.rb"
    end
  end

  def conf_sign_in_option
    if (defined? MobiCms.sign_in_path) and MobiCms.sign_in_path.present?
      send MobiCms.sign_in_path
    else
      raise " You'll need to define a 'sign_in_path'' method for MobiCms to use that points to the sign in path for your application. You can set MobiCms.sign_in_path in inside config/initializers/mobi_cms.rb"
    end
  end

  def cms_admin?
    mobi_cms_user && conf_admin_option
  end

  def conf_email_option
    if (defined? MobiCms.login_user_email_helper) and MobiCms.login_user_email_helper.present?
      send MobiCms.login_user_email_helper
    else
      raise " You'll need to define a 'login_user_email_helper' method for MobiCms login user email. You can set MobiCms.user_authenticate_method option in config/initializers/mobi_cms.rb"
    end
  end

  def conf_authenticate_option
    return if conf_email_option.blank?
    if (defined? MobiCms.user_authenticate_method) and MobiCms.user_authenticate_method.present?
      send MobiCms.user_authenticate_method
    else
      raise " You'll need to define a 'user_authenticate_method' method for MobiCms request authentication. You can set MobiCms.user_authenticate_method option in config/initializers/mobi_cms.rb"
    end
  end

  helper_method :cms_admin?, :conf_admin_option, :conf_sign_in_option

  def authenticate_cms_user
    unless mobi_cms_user
      redirect_to conf_sign_in_option, alert: "Please signed In"
    end
  end


  end
end
