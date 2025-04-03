class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # Ensure @user is never nil


   if @user.admin?
      can :manage, Order
      # can :manage, Product
      # can :manage, Business
      # cannot :read, ActiveAdmin::Page, name: "Dashboard" # Admin cannot access dashboard

    elsif @user.seller? || @user.user?
      can :read, :home
      can :manage, Order # Sellers & users can manage their own orders

    else
      can :read, :home # Guests can only view the homepage
    end
  end
end
