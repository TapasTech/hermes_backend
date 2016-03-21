# frozen_string_literal: true
class FileUploadedPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def remove?
    user.present? && record.uploadable.user == user
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
