require "mobi_cms/engine"
require 'carrierwave'

module MobiCms
  mattr_accessor :user_class, :sign_in_path
  
   class << self
    
    def user_class
      if @@user_class.is_a?(Class)
        raise "You can no longer set MobiCms.user_class to be a class. Please use a string instead."
      elsif @@user_class.is_a?(String)
        begin
          Object.const_get(@@user_class)
        rescue NameError
          @@user_class.constantize
        end
      end
    end
  end
end
