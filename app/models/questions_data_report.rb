class QuestionsDataReport < ApplicationRecord
  belongs_to :question
  belongs_to :data_report
end
