# frozen_string_literal: true
class QuestionsTopic < ApplicationRecord
  belongs_to :question
  belongs_to :topic
end
