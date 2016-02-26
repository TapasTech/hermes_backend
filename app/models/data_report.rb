class DataReport < ApplicationRecord
  has_many :questions_data_reports
  has_many :questions, through: :questions_data_reports

  has_many :answers_data_reports
  has_many :answers, through: :answers_data_reports
end
