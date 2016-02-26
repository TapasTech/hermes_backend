# frozen_string_literal: true
class CreateQuestionsDataReports < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_data_reports do |t|
      t.references :question, foreign_key: true
      t.references :data_report, foreign_key: true

      t.timestamps
    end
  end
end
