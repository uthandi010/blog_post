class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user 

    if user.roles.exists?(name: 'SUPER USER')
      can :manage, :all 
    else
      can :read, BlogPost
      can :manage, BlogPost, user_id: user.id
    end
  end
end
