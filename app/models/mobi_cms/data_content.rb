module MobiCms
  class DataContent < ActiveRecord::Base
    attr_accessible :content_type_id, :values, :contents
    attr_accessor :contents
    after_initialize :init
    before_validation :parse_and_set_attributes
    #serialize :values
    validates :values, presence: true

    belongs_to :content_type

    def init
      inputs_hash = JSON.parse self.content_type.content_type_attributes
      inputs_hash.each do |data_key, data_hash|
        self.instance_eval do
          self.class.send(:define_method, data_hash['title']) do
            instance_variable_get("@abc")
          end        
          self.class.send(:define_method, "#{data_hash['title']}=") do |val|
            instance_variable_set("@abc",val)
          end
        end 
      end
    end

    def parse_and_set_attributes
      # Assign values to instance variables
      attr_hash = self.contents.blank? ? (JSON.parse self.values)  : self.contents
      unless attr_hash.blank?
        attr_hash.each do |content_key, content_value|
          self.send("#{content_key}=", content_value)
        end
        self.values = self.contents.to_json
      else
        self.values = nil
      end
    end

    
  end
end
