# frozen_string_literal: true
class CreateFollowments < ActiveRecord::Migration[5.0]
  def change
    create_table :followments do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps
    end

    add_foreign_key :followments, :users,
                    column: :follower_id,
                    primary_key: :id
    add_foreign_key :followments, :users,
                    column: :followee_id,
                    primary_key: :id
    add_index :followments, :follower_id
    add_index :followments, :followee_id
  end
end
