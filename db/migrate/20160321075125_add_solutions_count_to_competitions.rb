# frozen_string_literal: true
class AddSolutionsCountToCompetitions < ActiveRecord::Migration
  def self.up
    add_column :competitions, :solutions_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :competitions, :solutions_count
  end
end
