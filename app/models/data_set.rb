# frozen_string_literal: true
class DataSet < ApplicationRecord
  has_many :questions_data_sets
  has_many :questions, through: :questions_data_sets

  has_many :answers_data_sets
  has_many :answers, through: :answers_data_sets

  validates :title, presence: true
  validates :url,   presence: true
end
