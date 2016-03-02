# frozen_string_literal: true
class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.references :answer, foreign_key: true
      t.jsonb :payload
      t.text :verb

      t.timestamps
    end
    add_index :activities, :payload
    add_index :activities, :verb
  end
end
