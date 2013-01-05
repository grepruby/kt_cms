module MobiCms
  class ContentType < ActiveRecord::Base
    SINGLE_ATTRIBUTE_META_DATA = {'title' => "", 'unique' => false, 'data_type' => '', 'mendatory' => false, 'errors' => "", 'multi_options' => '', 'maxlength' => "", "minlength" => ""}
    
    DATA_TYPES = [
      ["Text","string"],["Paragraph text","text"],
      ["Radio buttons", "radio"],["Checkboxes", "check_boxes"],
      ["Choose from a list", "select"], ["Integer", "integer"],
      ["Boolean", "boolean"], ["Decimal", "decimal"],
      ["Float", "float"], ["Date time", "datetime"],
      ["Date", "date"], ["Time", "time"], ["Email", "email"],
      ["Url", "url"], ["file", "File"]
    ]
    
    attr_accessible :content_type_attributes, :name, :elements, :hashed_elements, :template
    attr_accessor :elements, :hashed_elements
    validates :name, :content_type_attributes, :template, presence: true
    has_many :data_contents  

    before_validation :parse_and_set_attributes
    MULTI_OPTIONS = ["radio", "check_boxes", "select"]
    STRING_OPTIONS = ["text", "string"]
    private
    def parse_and_set_attributes
      set_hashed_elements
      errors.add(:base, "No attribute specified") and return if @elements.blank?

      @attributes_as_json = {}
      @error_flag = false
      @elements.each do |el|
        single_element = {}
        validate_element(el)
        single_element['title'] = el['title']
        single_element['multi_options'] = el['multi_options']
        single_element['data_type'] = el['data_type']
        if ContentType::STRING_OPTIONS.include? el['data_type']
          single_element['maxlength'] = el['maxlength']
          single_element['minlength'] = el['minlength'] 
        else
          single_element['maxlength'] = ""
          single_element['minlength'] = ""
        end
        single_element['mendatory'] = el['mendatory'].blank? ? false : true
        single_element['unique'] = el['unique'].blank? ? false : true
        key = el['title'].gsub(" ", "_").underscore
        @attributes_as_json[key] = single_element
      end

      errors.add(:base, "Somethings is missing for attribute, Please see below:")  if @error_flag
      self.content_type_attributes = @attributes_as_json.to_json
    end

    def validate_element(element)
      @error_flag = true and return if element.blank?
      if element['title'].blank?
        element['errors'] = "Title can't be blank" 
        @error_flag = true
      end
      if element['data_type'].blank?
        element['errors'] = "Data type can't be blank" 
        @error_flag = true
      else
        validate_multi_options(element)
      end
      validate_length_options(element)
    end

    def validate_length_options(element)
      if element['maxlength'].present? and element['maxlength'].to_i == 0
        element['errors'] = "Max length must be Integer"
        @error_flag = true
      end

      if element['minlength'].present? and element['minlength'].to_i == 0
        element['errors'] = "Min length must be Integer"
        @error_flag = true
      end
    end

    def validate_multi_options(element)
      if MULTI_OPTIONS.include? element['data_type']
        if element['multi_options'].blank?
          element['errors'] = "Options can't be blank"
          @error_flag = true
        end 
      else 
        element['multi_options'] = ""
      end
    end
    
    def set_hashed_elements
      if @elements.blank?
        @hashed_elements = {0 => SINGLE_ATTRIBUTE_META_DATA}
        return
      end
      element_hash = {}
      @elements.each_with_index{ |element, index| element_hash[index.to_s] = element}
      @hashed_elements = element_hash
    end

  end
end
