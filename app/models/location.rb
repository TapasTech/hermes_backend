# frozen_string_literal: true
class Location < ApplicationRecord
  acts_as_paranoid

  belongs_to :user

  validates :name, presence: true
end
