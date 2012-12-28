module MobiCms
  class DataContent < ActiveRecord::Base
    attr_accessible :content_type_id, :values

    belongs_to :content_type


  end
end
