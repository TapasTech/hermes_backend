# frozen_string_literal: true
class Solution < ApplicationRecord
  has_many :file_uploadeds, as: :uploadable
  belongs_to :competition
  belongs_to :user
end
