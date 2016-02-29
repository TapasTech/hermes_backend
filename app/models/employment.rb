# frozen_string_literal: true
class Employment < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :employment, presence: true
end
