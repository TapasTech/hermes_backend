# frozen_string_literal: true
class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :user, foreign_key: true
      t.text :name

      t.timestamps
    end
    add_index :locations, :name
  end
end
