class CreateQuestionsTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_topics do |t|
      t.references :question, foreign_key: true
      t.references :topic, foreign_key: true

      t.timestamps
    end
  end
end
