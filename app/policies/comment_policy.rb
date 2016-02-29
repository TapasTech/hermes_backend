class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.present?
  end

  def vote_up?
    user.present?
  end

  def vote_down?
    user.present?
  end
end
