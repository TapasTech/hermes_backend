# frozen_string_literal: true
class AddDeletedAtToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :deleted_at, :datetime
    add_index :votes, :deleted_at
  end
end
