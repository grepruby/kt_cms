module MobiCms
  class ContentType < ActiveRecord::Base


    attr_accessible :content_type_attributes ,:name ,:elements
    attr_accessor :elements
    validates :name, :content_type_attributes, presence: true


    validate :parse_and_set_attributes




    private
    def parse_and_set_attributes
      @attributes_as_json = []
      @error_flag = false
      @elements.each do |element|
        single_element = {}
        validate_elements(element)
        single_element['title'] = element['title']
        single_element['data_type'] = element['data_type']
        single_element['mendatory'] = element['mendatory'].blank? ? false : true
        single_element['unique'] = element['unique'].blank? ? false : true
        key = element['title'].gsub(" ", "_").underscore
        @attributes_as_json << single_element
      end
      errors.add(:base, "No attribute specified") if @attributes_as_json.blank?
      errors.add(:base, "Somethings is missing for elements, Please see below:") if @error_flag
      self.content_type_attributes = @attributes_as_json.to_json
    end

    def validate_elements(element)
      if element['title'].blank?
        element['errors'] = "Title can't be blank" 
        @error_flag = true
      end
      if element['data_type'].blank?
        element['errors'] = "Data type can't be blank" 
        @error_flag = true
      end
    end

  end
end
