# frozen_string_literal: true
class AddDeletedAtToBusinesses < ActiveRecord::Migration[5.0]
  def change
    add_column :businesses, :deleted_at, :datetime
    add_index :businesses, :deleted_at
  end
end
