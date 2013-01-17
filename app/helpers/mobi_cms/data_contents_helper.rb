module MobiCms
  module DataContentsHelper
  
    def display_data_content(data_key, data_value)
      case data_key
      when "check_boxes"
        checkbox_data(data_key, data_value)
      when "boolean"
        boolean_data(data_key, data_value)
      when "file"
        file_data(data_key, data_value)
      else
        return data_value
      end
    end

    def file_data(data_key, data_value)
      return "" if data_value.blank?
      asset = CmsAsset.where(:id => data_value)[0]
      if asset.present? and asset.file.present?
        content_tag(:a, asset.file.url, :href => asset.file.url) 
      else
        return ""
      end
    end

    def checkbox_data(data_key, data_value)
      data_value.delete("")
      data_value.to_sentence
    end

    def boolean_data(data_key, data_value)
      data_value == "1" ? "Yes" : "No"
    end


  end
end
