# frozen_string_literal: true
class CompetitionPolicy < ApplicationPolicy
  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
