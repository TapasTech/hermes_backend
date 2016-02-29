# frozen_string_literal: true
class Education < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :organization, presence: true
end
