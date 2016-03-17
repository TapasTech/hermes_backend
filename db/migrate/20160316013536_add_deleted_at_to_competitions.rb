# frozen_string_literal: true
class AddDeletedAtToCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :competitions, :deleted_at, :datetime
    add_index :competitions, :deleted_at
  end
end
