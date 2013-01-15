module MobiCms
  module Admin
    class BaseController < ApplicationController
      before_filter :authenticate_cms_user

    end
  end
end
