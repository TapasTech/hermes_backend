# frozen_string_literal: true
class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :votable, polymorphic: true, index: true
      t.integer :weight

      t.timestamps
    end
    add_index :votes, :weight
  end
end
