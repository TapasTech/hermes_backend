# frozen_string_literal: true
class UserPolicy < ApplicationPolicy
  def create?
    true
  end

  def update?
    record == user
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
