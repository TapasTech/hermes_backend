# frozen_string_literal: true
class AddFollowersCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :followers_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :users, :followers_count
  end
end
