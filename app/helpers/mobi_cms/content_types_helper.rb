module MobiCms
  module ContentTypesHelper

    def display_class(data_type)
      if data_type.present? and !ContentType::NOT_MULTI_OPTIONS.include? data_type
        "show"
      else
        "hide"
      end
    end
  end
end
