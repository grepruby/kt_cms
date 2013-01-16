module MobiCms
  module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

   def data_type_status_options
    ContentType::STATUS_OPTIONS
   end

    def get_status(is_active)
      is_active ? "Active" : "In-active"
    end

   def get_options_array(options_str)
      options_str.split(",")
    end
  end
end
