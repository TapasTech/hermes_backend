# frozen_string_literal: true
class AddDeletedAtToEducations < ActiveRecord::Migration[5.0]
  def change
    add_column :educations, :deleted_at, :datetime
    add_index :educations, :deleted_at
  end
end
