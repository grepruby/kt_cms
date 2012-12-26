module MobiCms
  class ContentType < ActiveRecord::Base
    attr_accessible :content_type_attributes, :name
  end
end
