# frozen_string_literal: true
class AddCommentsCountToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :comments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :answers, :comments_count
  end
end
