# frozen_string_literal: true
class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def vote_up?
    user.present?
  end

  def vote_down?
    user.present?
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
