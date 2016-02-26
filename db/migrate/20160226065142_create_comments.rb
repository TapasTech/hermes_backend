# frozen_string_literal: true
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.integer :reply_to_id
      t.references :answer, foreign_key: true
      t.string :content

      t.timestamps
    end
    add_foreign_key :comments, :users,
                    column: :reply_to_id,
                    primary_key: :id
    add_index :comments, :reply_to_id
  end
end
