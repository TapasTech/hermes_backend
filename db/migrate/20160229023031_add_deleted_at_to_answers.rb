# frozen_string_literal: true
class AddDeletedAtToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :deleted_at, :datetime
    add_index :answers, :deleted_at
  end
end
