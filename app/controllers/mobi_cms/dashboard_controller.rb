module MobiCms
  class DashboardController < MobiCms::ApplicationController
    before_filter :authenticate_cms_user

    def index

    end
  
  end
end
