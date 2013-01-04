module MobiCms
  module ContentTypesHelper

    def display_class(data_type)
      if data_type.present? and ContentType::MULTI_OPTIONS.include? data_type
        "show"
      else
        "hide"
      end
    end

    def display_class_for_lenth(data_type)
      if ContentType::STRING_OPTIONS.include? data_type
        "show"
      else
        "hide"
      end
    end
    
    def data_type_options
      ContentType::DATA_TYPES
    end
  end
end
