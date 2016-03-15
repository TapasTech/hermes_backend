# frozen_string_literal: true
class CreateFileUploadeds < ActiveRecord::Migration[5.0]
  def change
    create_table :file_uploadeds do |t|
      t.text :name
      t.integer :size
      t.text :description
      t.text :format
      t.text :url

      t.references :uploadable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
