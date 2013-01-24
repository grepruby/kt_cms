require 'cancan'

module MobiCms
  class Ability
    include CanCan::Ability
    def initialize(user)

      if user
        if user.is_admin?
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
