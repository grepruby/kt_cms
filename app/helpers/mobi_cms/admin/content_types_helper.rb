module MobiCms
  module Admin::ContentTypesHelper

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

    def data_type_status_options
      ContentType::STATUS_OPTIONS
    end
  end
end
