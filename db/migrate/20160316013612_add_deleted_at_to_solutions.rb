# frozen_string_literal: true
class AddDeletedAtToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_column :solutions, :deleted_at, :datetime
    add_index :solutions, :deleted_at
  end
end
