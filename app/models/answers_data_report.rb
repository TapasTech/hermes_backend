# frozen_string_literal: true
class AnswersDataReport < ApplicationRecord
  belongs_to :answer
  belongs_to :data_report
end
