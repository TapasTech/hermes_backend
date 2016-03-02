# frozen_string_literal: true
class CreateDataReports < ActiveRecord::Migration[5.0]
  def change
    create_table :data_reports do |t|
      t.text :title
      t.text :url

      t.timestamps
    end
    add_index :data_reports, :url
  end
end
