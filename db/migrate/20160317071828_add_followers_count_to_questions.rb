# frozen_string_literal: true
class AddFollowersCountToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :followers_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :questions, :followers_count
  end
end
