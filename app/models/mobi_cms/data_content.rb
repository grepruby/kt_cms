module MobiCms
  class DataContent < ActiveRecord::Base
    attr_accessible :content_type_id, :values, :contents
    attr_accessor :contents
    after_initialize :init
    before_validation :parse_and_set_attributes
    after_validation :remove_unwanted_error_messages
    before_create :create_other_attributes
    before_update :update_other_attributes
    after_destroy :remove_assets
    validates :values, :content_type_id, presence: true
    FILE_OPTIONS = ["file"]

    belongs_to :content_type


    def init
      return unless content_type_present?
      inputs_hash = JSON.parse(self.content_type.content_type_attributes)
      inputs_hash.each do |data_key, data_hash|
        define_getter_setter_for(data_key)
      end
    end

    def update_other_attributes
      @content_type_hash = JSON.parse self.content_type.content_type_attributes
      return unless file_data_type_include?#check file data type
      attr_hash = self.contents.blank? ? (JSON.parse self.values) : self.contents
      @content_type_hash.each do |content_key, content_option|
        content_value = attr_hash[content_key]
        if FILE_OPTIONS.include?(content_option["data_type"])
          if content_value.present?
            cms_upload = CmsAsset.create(:file => content_value)
            self.contents[content_key] = cms_upload.id
            self.values = self.contents.to_json
            delete_cms_asset content_key
          else
            exist_hash = JSON.parse(DataContent.find(self.id).values)
            self.contents[content_key] = exist_hash[content_key]
            self.values = self.contents.to_json
          end
        end
      end
    end

    def file_data_type_include?
      @content_type_hash.collect{ |type_hash,val| val["data_type"] }.select{|data_type| FILE_OPTIONS.include?(data_type)}.present?
    end

    def remove_assets
      @content_type_hash = JSON.parse self.content_type.content_type_attributes
      return unless file_data_type_include?#check file data type
      exist_hash = JSON.parse(self.values)
      content_type_hash = JSON.parse self.content_type.content_type_attributes
      content_type_hash.each do |content_key, content_option|
        if FILE_OPTIONS.include?(content_option["data_type"]) and exist_hash[content_key].present?
          old = CmsAsset.where(:id => exist_hash[content_key])[0]
          old.destroy if old.present?
        end
      end
    end

    def delete_cms_asset(content_key)
      exist_hash = JSON.parse(DataContent.find(self.id).values)
      old = CmsAsset.where(:id => exist_hash[content_key])[0] if exist_hash[content_key].present?
      old.destroy if old.present?
    end

    def create_other_attributes
      @content_type_hash = JSON.parse self.content_type.content_type_attributes
      return unless file_data_type_include?#check file data type
      attr_hash = self.contents.blank? ? (JSON.parse self.values) : self.contents
      @content_type_hash.each do |content_key, content_option|
        content_value = attr_hash[content_key]
        if FILE_OPTIONS.include?(content_option["data_type"]) and content_value.present?
          cms_upload = CmsAsset.create(:file => content_value)
          self.contents[content_key] = cms_upload.id
          self.values = self.contents.to_json
        end
      end
    end

      # Assign values to instance variables
    def parse_and_set_attributes(should_validate = true)
      return unless content_type_present?
      attr_hash = self.contents.blank? ? (JSON.parse self.values) : self.contents
      unless attr_hash.blank?
        @content_type_hash = JSON.parse self.content_type.content_type_attributes
        @invalid_flag = false
        @content_type_hash.each do |content_key, content_option|
          content_value = attr_hash[content_key]
          self.send("#{content_key}=", content_value)
          
          if should_validate #avoid edit case
            validate_data_content content_key, content_value 
            validates_attr_length(content_key, content_value, content_option["maxlength"], content_option["minlength"])
            validates_attribute_value(content_key, content_value)
          end
        end
        self.values = @invalid_flag ? nil : self.contents.to_json
      else
        self.values = nil
      end
    end

    protected

    def validates_attribute_value(content_key, content_value)
      attr_type = @content_type_hash[content_key]["data_type"]
      case attr_type
      when "integer"
        validate_attr_for_integer(content_key, content_value)
      when "boolean"
        validate_attr_for_boolean(content_key, content_value)
      when "email"
        validate_attr_for_email(content_key, content_value)
      when "url"
        validate_attr_for_url(content_key, content_value)
      when "float"
        validate_attr_for_float(content_key, content_value)
      when "date_picker"
        validate_attr_for_date(content_key, content_value)
      when "ui_date_time_picker"
        validate_attr_for_datetime(content_key, content_value)
      when "time_picker"
        validate_attr_for_time(content_key, content_value)
      else
        return
      end
    end

    # check date data value
    def validate_attr_for_date(content_key, content_value)
      return if content_value.blank?
      begin Date.strptime(content_value.to_s, "%m/%d/%Y")
      rescue ArgumentError
        errors.add content_key, "should be a date format"
      end
    end

    # check datetime data value
    def validate_attr_for_datetime(content_key, content_value)
      return if content_value.blank?
      begin DateTime.strptime(content_value.to_s, "%m/%d/%Y %H:%M")
      rescue ArgumentError
        errors.add content_key, "should be a datetime format"
      end
    end

    # check time data value
    def validate_attr_for_time(content_key, content_value)
      return if content_value.blank?
      begin Time.parse(content_value)
      rescue ArgumentError
        errors.add content_key, "should be a datetime format"
      end
    end  

    # check url data value
    def validate_attr_for_url(content_key, content_value)
      errors.add content_key, "should be a valid url" if content_value.present? and (content_value.match(/^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix).nil?)
    end

    # check email data value
    def validate_attr_for_email(content_key, content_value)
      errors.add content_key, "should be a valid email address" if content_value.present? and (content_value.match(/^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i).nil?)
    end

    # check integer data value
    def validate_attr_for_integer(content_key, content_value)
      return if content_value.blank?
      if !is_integer?(content_value)
        errors.add content_key, "should be only integer value"
      end
    end

    # check float data value
    def validate_attr_for_float(content_key, content_value)
      return if content_value.blank?
      if !is_numeric?(content_value)
        errors.add content_key, "should be only numeric value"
      end
    end

    # check integer value
    def is_integer?(i)
      !!i.match(/^[0-9]+$/)
    end

    # check numeric value
    def is_numeric?(i)
      true if Float(i) rescue false
    end

    # check boolean data value
    def validate_attr_for_boolean(content_key, content_value)
      errors.add content_key, "should be only boolean value" if content_value.present? and !["1", "0"].include? content_value
    end

    # check data length
    def validates_attr_length(content_key, content_value, max_val, min_val)
      errors.add content_key, "must have maximum #{max_val} length" if content_value.present? and max_val.present? and (max_val.to_i < content_value.length)
      errors.add content_key, "must have minimum #{min_val} length" if content_value.present? and min_val.present? and (min_val.to_i > content_value.length)      
    end

    def validate_data_content content_key, content_value
      # Validates for mendatory
      if @content_type_hash[content_key]["mendatory"] === true
        validate_with_mendatory_option content_key, content_value 
      end
      # Validate for uniqueness
      if @content_type_hash[content_key]["unique"] === true
        validate_with_unique_option content_key, content_value
      end
    end

    def validate_with_mendatory_option content_key, content_value
      if content_value.blank?
        errors.add :base, "#{content_key  } can't be blank" 
        @invalid_flag = true
      end
    end

    def validate_with_unique_option content_key, content_value
      return
      errors.add :base, "#{content_key  } is already exist" 
      @invalid_flag = true
    end

    def define_getter_setter_for(attribute_key)
      self.instance_eval do
        # Getter
        self.class.send(:define_method, attribute_key) do
          instance_variable_get("@#{attribute_key}")
        end
        # Setter
        self.class.send(:define_method, "#{attribute_key}=") do |val|
          instance_variable_set("@#{attribute_key}", val)
        end
      end 
    end

    def content_type_present?
      if self.content_type.blank?
        errors.add(:base, "No content type is defined")
        return false
      end
      return true
    end

    def remove_unwanted_error_messages
      if self.errors.messages.keys.include?(:values)
        self.errors.messages.delete(:values)
      end
    end
  end
end
