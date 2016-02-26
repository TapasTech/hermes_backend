# frozen_string_literal: true
class CreateQuestionsDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_data_sets do |t|
      t.references :question, foreign_key: true
      t.references :data_set, foreign_key: true

      t.timestamps
    end
  end
end
