# frozen_string_literal: true
class AddAnswersCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :answers_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :answers_count
  end
end
