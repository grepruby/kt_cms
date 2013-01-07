class UiDateTimePickerInput < SimpleForm::Inputs::StringInput 
  def input                    
    input_html_classes << " ui-datetime-picker"

    super # leave StringInput do the real rendering
  end
end
