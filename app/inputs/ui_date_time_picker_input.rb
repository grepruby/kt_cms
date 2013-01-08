class UiDateTimePickerInput < SimpleForm::Inputs::Base

  def input
    input_html_options[:readonly] = true
    input_html_options[:class] << 'ui-datetime-picker'
    %{
      <div class="input-append date">
        #{@builder.text_field(attribute_name, input_html_options)}
        <span class="add-on">
          <i class="icon-calendar"></i>
        </span>
      </div>
    }.html_safe
     # leave StringInput do the real rendering
  end
end
