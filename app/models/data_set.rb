# frozen_string_literal: true
class DataSet < ApplicationRecord
  acts_as_paranoid
  belongs_to :user

  has_many :questions_data_sets
  has_many :questions, through: :questions_data_sets

  has_many :answers_data_sets
  has_many :answers, through: :answers_data_sets

  has_many :file_uploadeds, as: :uploadable

  validates :title, presence: true
  validates :url,   presence: true
end
