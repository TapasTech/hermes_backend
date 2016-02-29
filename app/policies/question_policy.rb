# frozen_string_literal: true
class QuestionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.present?
  end

  def update?
    record.user == user
  end

  def add_topic?
    user.present?
  end

  def remove_topc?
    record.user == user
  end

  def add_data_set?
    user.present?
  end

  def remove_data_set?
    record.user == user
  end

  def add_data_report?
    user.present?
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
end
