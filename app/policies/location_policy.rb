# frozen_string_literal: true
class LocationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    record.user == user
  end
end
