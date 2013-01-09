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
      asset = CmsAsset.find(data_value)
      if asset.present?
        root_url + asset.file.url
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
