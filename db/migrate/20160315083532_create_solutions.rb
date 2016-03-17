# frozen_string_literal: true
class CreateSolutions < ActiveRecord::Migration[5.0]
  def change
    create_table :solutions do |t|
      t.text :description

      t.references :competition, foreign_key: true
      t.timestamps
    end
  end
end
