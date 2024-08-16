class LeavePolicy < ApplicationPolicy

  def index?
    true
  end

  def create?
    user.hr? || user.employee?
  end

  def update?
    user.manager?
  end

  class Scope < BaseScope; end

end
