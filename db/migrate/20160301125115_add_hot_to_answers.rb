# frozen_string_literal: true
class AddHotToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :hot, :float
    add_index :answers, :hot
  end
end
