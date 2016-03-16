# frozen_string_literal: true
class FileUploadedPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
