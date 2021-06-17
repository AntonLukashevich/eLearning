# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)

    if user.role_id == 1 # user.role == 'user'
      can %i[read create subscribe unsubscribe my_courses publications], Course
      can [:update, :destroy, :request_to, :authors, :delete_author, :new_author], Course do |course|
        course.users.include?(user)
      end

      can [:update, :destroy, :read, :create], Organization do |org|
        org.user.id == user.id
      end

      cannot [:subscribe], Course do |course|
        course.users.include?(user)
      end

      can :manage, User, id: user.id
      can [:sing_up], Devise
    else
      # can [:],Devise
      can [:show], User
      can [:show], Organization
      cannot [:index], User
      can %i[read subscribe], Course
    end

    can :manage, :all if user.role_id == 2 # user.role == 'admin'
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
