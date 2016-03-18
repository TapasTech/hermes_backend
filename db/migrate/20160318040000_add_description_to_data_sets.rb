# frozen_string_literal: true
class AddDescriptionToDataSets < ActiveRecord::Migration[5.0]
  def change
    add_column :data_sets, :description, :text
  end
end
