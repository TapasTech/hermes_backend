# frozen_string_literal: true
class AnswersDataSet < ApplicationRecord
  belongs_to :answer
  belongs_to :data_set
end
