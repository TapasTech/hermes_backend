# frozen_string_literal: true
class AddQuestionsCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :questions_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :questions_count
  end
end
