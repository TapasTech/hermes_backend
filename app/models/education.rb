# frozen_string_literal: true
class Education < ApplicationRecord
  belongs_to :user

  validates :organization, presence: true
end
