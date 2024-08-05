class OrganizationPolicy < ApplicationPolicy
  def index?
    user.hr?
  end

  def show?
    user.hr?
  end

  def create?
    user.hr?
  end

  def update?
    user.hr?
  end

  def destroy?
    user.hr?
  end
end
