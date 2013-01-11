module MobiCms
  class MobiCms::ApplicationController < ApplicationController
    layout 'mobi_cms/application'


    private

    def authenticate_mobi_admin_user
      if !mobi_cms_user
        session["user_return_to"] = request.fullpath
        flash.alert = "Please signed In"
        devise_route = "new_#{MobiCms.user_class.to_s.underscore}_session_path"
        sign_in_path = MobiAdmin.sign_in_path ||
          (main_app.respond_to?(devise_route) && main_app.send(devise_route)) ||
          (main_app.respond_to?(:sign_in_path) && main_app.send(:sign_in_path))
        if sign_in_path
          redirect_to sign_in_path
        else
          raise "MobiCms could not determine the sign in path for your application. Please do one of these things:
                1) Define sign_in_path in the config/routes.rb of your application like this:
                or; 2) Set MobiCms.sign_in_path to a String value that represents the location of your sign in form, such as '/users/sign_in'."
        end
      end
    end


  end
end
