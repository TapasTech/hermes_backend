# frozen_string_literal: true
class QuestionsFollowment < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee_question, class_name: 'Question'
end
