# frozen_string_literal: true
class Location < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
end
