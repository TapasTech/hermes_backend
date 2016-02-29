# frozen_string_literal: true
class EmploymentPolicy < ApplicationPolicy
  def update?
    record.user == user
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
