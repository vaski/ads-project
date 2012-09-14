class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.role == 'admin'
      can :read, :all
      can :manage, User
      can [:destroy, :approve, :reject], Ad
    else
      can :read, Ad

      if user.role == 'user'
        can :read, User, id: user.id
        can :create, Ad
        can [:update, :destroy, :verify], Ad, user_id: user.id
      end
    end
  end
end
