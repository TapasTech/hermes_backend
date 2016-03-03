# frozen_string_literal: true
class IndexCreatedAtToActivities < ActiveRecord::Migration[5.0]
  def change
    add_index :activities, :created_at
  end
end
