module MobiCms
  module DataContentsHelper
  
    def display_data_content(data_key, data_value)
      case data_key
      when "check_boxes"
        checkbox_data(data_key, data_value)
      when "boolean"
        boolean_data(data_key, data_value)
      else
        return data_value
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
