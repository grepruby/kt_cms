class TimePickerInput < SimpleForm::Inputs::Base
  def input                    
    input_html_options[:class] << 'ui-time-picker'
    input_html_options[:class] << 'input-small'
    input_html_options[:readonly] = true
    %{
      <div class="input-append bootstrap-timepicker-component">
        #{@builder.text_field(attribute_name, input_html_options)}
        <span class="add-on">
          <i class="icon-time"></i>
        </span>
      </div>
    }.html_safe
  end
end
