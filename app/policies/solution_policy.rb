# frozen_string_literal: true
class SolutionPolicy < ApplicationPolicy
  def create?
    user.present? && record.competition.present? &&
      record.competition.open?
  end

  def update?
    user.present? && record.competition.present? && record.competition.open? &&
      record.user == user
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
