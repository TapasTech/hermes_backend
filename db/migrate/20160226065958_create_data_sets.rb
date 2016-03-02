# frozen_string_literal: true
class CreateDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sets do |t|
      t.text :title
      t.text :url

      t.timestamps
    end
    add_index :data_sets, :url
  end
end
