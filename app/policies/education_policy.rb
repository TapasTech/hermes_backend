# frozen_string_literal: true
class EducationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    record.user == user
  end
end
