# frozen_string_literal: true
class AddDeletedAtToDataSets < ActiveRecord::Migration[5.0]
  def change
    add_column :data_sets, :deleted_at, :datetime
    add_index :data_sets, :deleted_at
  end
end
