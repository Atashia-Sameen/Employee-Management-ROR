class AttendancePolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.hr? || user.employee?
  end

  def create?
    new?
  end

  class Scope < BaseScope; end

end
