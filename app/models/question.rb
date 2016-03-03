# frozen_string_literal: true
class Question < ApplicationRecord
  include Votable
  acts_as_paranoid

  belongs_to :user

  has_many :questions_topics
  has_many :topics, through: :questions_topics

  has_many :questions_data_sets
  has_many :data_sets, through: :questions_data_sets

  has_many :questions_data_reports
  has_many :data_reports, through: :questions_data_reports

  has_many :answers
  delegate :count, to: :answers, prefix: true

  has_many :questions_followments, foreign_key: :followee_question_id
  has_many :followers, through: :questions_followments,
                       class_name: 'User',
                       inverse_of: :followee_questions

  delegate :count, to: :followers, prefix: true

  validates :title, presence: true
end
