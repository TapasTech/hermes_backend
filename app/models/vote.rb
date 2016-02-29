# frozen_string_literal: true
class Vote < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :votable, polymorphic: true

  validates :weight, presence: true
end
