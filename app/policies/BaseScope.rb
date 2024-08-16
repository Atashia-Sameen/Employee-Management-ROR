class BaseScope < ApplicationPolicy::Scope
  def resolve
    if user.manager?
      scope.all
    else
      scope.where(user: user)
    end
  end
end
