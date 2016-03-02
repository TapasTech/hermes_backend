# frozen_string_literal: true
class CreateTopics < ActiveRecord::Migration[5.0]
  def change
    create_table :topics do |t|
      t.text :name
      t.text :description
      t.integer :origin_id

      t.timestamps
    end
    add_foreign_key :topics, :topics,
                    column: :origin_id,
                    primary_key: :id
    add_index :topics, :name
    add_index :topics, :origin_id
  end
end
