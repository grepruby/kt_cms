require 'carrierwave/orm/activerecord'
module MobiCms
  class CmsAsset < ActiveRecord::Base
    attr_accessible :file
    mount_uploader :file, CmsAssetUploader
  end
end
