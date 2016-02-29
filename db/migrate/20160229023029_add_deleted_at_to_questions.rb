# frozen_string_literal: true
class AddDeletedAtToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :deleted_at, :datetime
    add_index :questions, :deleted_at
  end
end
