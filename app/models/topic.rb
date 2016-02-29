# frozen_string_literal: true
class Topic < ApplicationRecord
  acts_as_paranoid

  belongs_to :origin, class_name: 'Origin',
                      required: false
  has_many :aliases, class_name: 'Origin',
                     foreign_key: 'origin_id'

  has_many :questions_topics
  has_many :questions, through: :questions_topics

  validates :name, presence: true
end
