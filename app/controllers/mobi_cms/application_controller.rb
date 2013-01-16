require 'cancan'
module MobiCms
  class MobiCms::ApplicationController < ApplicationController
    layout 'mobi_cms/application'
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to mobi_cms.root_path, :alert => exception.message
    end

  def current_ability
    MobiCms::Ability.new(mobi_cms_user)
  end


  private

  def cms_admin?
    mobi_cms_user && mobi_cms_user.cms_admin
  end
  helper_method :cms_admin?

  def authenticate_cms_user
    if !mobi_cms_user
      session["user_return_to"] = request.fullpath
      flash.alert = "Please signed In"
      devise_route = "new_#{MobiCms.user_class.to_s.underscore}_session_path"
      sign_in_path = MobiCms.sign_in_path ||
        (main_app.respond_to?(devise_route) && main_app.send(devise_route)) ||
        (main_app.respond_to?(:sign_in_path) && main_app.send(:sign_in_path))
      if sign_in_path
        redirect_to sign_in_path
      else
        raise " You'll need to define a 'sign_in_path'' method for MobiCms to use that points to the sign in path for your application. You can set MobiCms.sign_in_path to a String inside config/initializers/mobi_cms.rb to do this, or you can define it in your config/routes.rb file with a line like this:
        get '/users/sign_in', :to => 'users#sign_in'

        Either way, MobiCms needs one of these two things in order to work properly. Please define them!"
      end
    end
  end


  end
end
