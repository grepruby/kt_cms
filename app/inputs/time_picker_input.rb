class TimePickerInput < SimpleForm::Inputs::StringInput 
  def input                    
    input_html_classes << " ui-time-picker"
    super # leave StringInput do the real rendering
  end
end
