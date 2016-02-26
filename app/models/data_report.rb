# frozen_string_literal: true
class DataReport < ApplicationRecord
  has_many :questions_data_reports
  has_many :questions, through: :questions_data_reports

  has_many :answers_data_reports
  has_many :answers, through: :answers_data_reports

  validates :title, presence: true
  validates :url,   presence: true
end
