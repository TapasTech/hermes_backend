# frozen_string_literal: true
class AddDeletedAtToFileUploadeds < ActiveRecord::Migration[5.0]
  def change
    add_column :file_uploadeds, :deleted_at, :datetime
    add_index :file_uploadeds, :deleted_at
  end
end
