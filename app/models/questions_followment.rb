# frozen_string_literal: true
class QuestionsFollowment < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee_question, class_name: 'Question'
  counter_culture :followee_question, column_name: 'followers_count'
end
