module MobiCms
  class DashboardController < MobiCms::ApplicationController
    layout :cms_layout

    def index
      @users = MobiCms.user_class.all
      @content_types = MobiCms::ContentType.activated.latest
    end
  
  end
end
