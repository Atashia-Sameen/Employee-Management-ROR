class LeavePolicy < ApplicationPolicy

  def index?
    user.hr? || user.manager? || user.employee?
  end

  def create?
    user.hr? || user.employee?
  end

  def update?
    user.manager?
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
