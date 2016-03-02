# frozen_string_literal: true
class CreateQuestionsFollowments < ActiveRecord::Migration[5.0]
  def change
    create_table :questions_followments do |t|
      t.integer :follower_id
      t.integer :followee_question_id

      t.timestamps
    end
    add_foreign_key :questions_followments, :users,
                    column: :follower_id,
                    primary_key: :id
    add_foreign_key :questions_followments, :questions,
                    column: :followee_question_id,
                    primary_key: :id
    add_index :questions_followments, :follower_id
    add_index :questions_followments, :followee_question_id
  end
end
