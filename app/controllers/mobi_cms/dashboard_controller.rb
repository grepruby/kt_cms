module MobiCms
  class DashboardController < MobiCms::ApplicationController
    before_filter :authenticate_cms_user

    def index
      @users = MobiCms.user_class.all
      @content_types = MobiCms::ContentType.activated.latest
    end
  
  end
end
