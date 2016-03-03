# frozen_string_literal: true
class DataReportPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user == record.user
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
