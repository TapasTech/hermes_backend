class CreateAnswersDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :answers_data_sets do |t|
      t.references :answer, foreign_key: true
      t.references :data_set, foreign_key: true

      t.timestamps
    end
  end
end
