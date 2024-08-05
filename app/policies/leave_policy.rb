class LeavePolicy < ApplicationPolicy

  def index?
    user.hr? || user.manager? || user.employee?
  end

  def show?
    user.hr? || user.manager? || record.user_id == user.id
  end

  def create?
    user.hr? || user.manager? || user.employee?
  end

  def update?
    user.hr? || (user.manager? && record.user.organization_id == user.organization_id) || record.user_id == user.id
  end

  def destroy?
    user.hr? || (user.manager? && record.user.organization_id == user.organization_id) || record.user_id == user.id
  end

  class Scope < Scope
    def resolve
      if user.manager?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
