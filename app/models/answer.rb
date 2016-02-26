# frozen_string_literal: true
class Answer < ApplicationRecord
  belongs_to :question

  has_many :answers_data_sets
  has_many :data_sets, through: :answers_data_sets

  has_many :answers_data_reports
  has_many :data_reports, through: :answers_data_reports
  has_many :comments

  validates :content, presence: true
end
