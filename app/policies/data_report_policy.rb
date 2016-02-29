# frozen_string_literal: true
class DataReportPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.present?
  end
end
