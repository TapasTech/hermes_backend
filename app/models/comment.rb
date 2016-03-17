# frozen_string_literal: true
class Comment < ApplicationRecord
  include Rankable
  acts_as_paranoid

  belongs_to :user
  belongs_to :reply_to, class_name: 'User'
  belongs_to :answer
  counter_culture :answer

  validates :content, presence: true
end
