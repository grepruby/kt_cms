require 'cancan'

module MobiCms
  class Ability
    include CanCan::Ability

    def initialize(user)
      user ||= Forem.user_class.new
      if user
        if user.cms_admin?
          can :manage, MobiCms::ContentType
          can :manage, MobiCms::DataContent
        else
          can :manage, MobiCms::DataContent do |data_content|
            data_content.try(:user) == user
          end        
        end
      end

    end
  end
end
