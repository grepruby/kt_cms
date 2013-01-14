module MobiCms
  module Admin
    class BaseController < ApplicationController
      before_filter :authenticate_cms_user
      before_filter :authenticate_cms_admin

      private

      def authenticate_cms_admin
        if !cms_admin?
          flash.alert = "Access denied"
          redirect_to "/"
        end
      end
    end
  end
end
