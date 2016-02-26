# frozen_string_literal: true
class Question < ApplicationRecord
  include Votable
  belongs_to :user

  has_many :questions_topics
  has_many :topics, through: :questions_topics

  has_many :questions_data_sets
  has_many :data_sets, through: :questions_data_sets

  has_many :questions_data_reports
  has_many :data_reports, through: :questions_data_reports

  has_many :answers

  validates :title,   presence: true
  validates :content, presence: true
end
