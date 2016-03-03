# frozen_string_literal: true
class AnswerPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def add_data_set?
    record.user == user
  end

  def remove_data_set?
    record.user == user
  end

  def add_data_report?
    record.user == user
  end

  def remove_data_report?
    record.user == user
  end

  def vote_up?
    user.present?
  end

  def vote_down?
    user.present?
  end

  # Authorized Visible Scope
  class Scope < Scope
    def resolve
      scope
    end
  end
end
