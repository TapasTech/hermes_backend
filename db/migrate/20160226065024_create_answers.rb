# frozen_string_literal: true
class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.references :user
      t.references :question, foreign_key: true
      t.text :content
      t.datetime :edited_at

      t.timestamps
    end
  end
end
