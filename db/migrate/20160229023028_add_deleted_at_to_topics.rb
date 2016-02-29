# frozen_string_literal: true
class AddDeletedAtToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :deleted_at, :datetime
    add_index :topics, :deleted_at
  end
end
