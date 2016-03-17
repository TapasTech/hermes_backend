# frozen_string_literal: true
class CreateCompetitions < ActiveRecord::Migration[5.0]
  def change
    create_table :competitions do |t|
      t.text :title
      t.text :description
      t.text :logo_url
      t.datetime :start_at
      t.datetime :expire_at
      t.decimal :award, precision: 11, scale: 2
      t.text :competition_type

      t.timestamps
    end

    add_index :competitions, :title
    add_index :competitions, :created_at
  end
end
