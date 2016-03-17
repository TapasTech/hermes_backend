# frozen_string_literal: true
class SolutionPolicy < ApplicationPolicy
  def create?
    user.present? && record.competition.present? &&
      record.competition.open?
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
