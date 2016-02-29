# frozen_string_literal: true
class AddDeletedAtToEmployments < ActiveRecord::Migration[5.0]
  def change
    add_column :employments, :deleted_at, :datetime
    add_index :employments, :deleted_at
  end
end
