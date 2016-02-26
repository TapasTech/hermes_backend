class QuestionsDataSet < ApplicationRecord
  belongs_to :question
  belongs_to :data_set
end
