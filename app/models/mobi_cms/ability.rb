require 'cancan'

module MobiCms
  class Ability
    include CanCan::Ability
    def initialize(user)
      user ||= MobiCms.user_class.new
      if user
        if true
          can :manage, MobiCms::ContentType
          can :manage, MobiCms::DataContent
        else
          can :manage, MobiCms::DataContent do |data_content|
            data_content.user.id == user.id
          end        
        end
      end

    end
  end
end
