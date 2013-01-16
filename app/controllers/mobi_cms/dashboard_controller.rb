module MobiCms
  class DashboardController < MobiCms::ApplicationController

    def index
      @users = MobiCms.user_class.all
      @content_types = MobiCms::ContentType.activated.latest
      if mobi_cms_user.blank?
        render :action => "public_home", :layout => "layouts/mobi_cms/public"
      else
        render :action => "index"
      end
    end
  
  end
end
