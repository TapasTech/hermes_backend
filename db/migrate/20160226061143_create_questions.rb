# frozen_string_literal: true
class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true
      t.text :title
      t.text :content
      t.datetime :edited_at

      t.timestamps
    end
  end
end
