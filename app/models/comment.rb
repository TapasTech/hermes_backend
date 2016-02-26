# frozen_string_literal: true
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :reply_to, class_name: 'User'
  belongs_to :answer

  validates :content, presence: true
end
