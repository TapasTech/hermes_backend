# frozen_string_literal: true
class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :weight, presence: true
end
