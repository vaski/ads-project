class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :read, :all
      can :create, User
      can [:destroy, :update, :assign_role], User do |usr|
        user.id != usr.id
      end
      can [:destroy, :approve, :reject], Ad
      can :manage, Category
    else
      can :read, Ad, state: 'published'

      if user.user?
        can :read, User, id: user.id
        can :create, Ad
        can [:read, :update, :destroy, :verify], Ad, user_id: user.id
      end
    end
  end
end
