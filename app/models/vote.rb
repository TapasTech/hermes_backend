# frozen_string_literal: true
class Vote < ApplicationRecord
  scope :ups, -> { where('weight > 0') }
  scope :downs, -> { where('weight < 0') }

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :weight, presence: true
end
