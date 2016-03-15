# frozen_string_literal: true
class Topic < ApplicationRecord
  acts_as_paranoid

  max_paginates_per 50
  paginates_per 50

  belongs_to :origin, class_name: 'Topic',
                      required: false
  has_many :aliases, class_name: 'Topic',
                     foreign_key: 'origin_id'

  has_many :questions_topics
  has_many :questions, through: :questions_topics

  validates :name, presence: true
end
