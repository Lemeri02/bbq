class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def show?
    true
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end
end
