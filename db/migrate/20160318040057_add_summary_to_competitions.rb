# frozen_string_literal: true
class AddSummaryToCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :competitions, :summary, :text
  end
end
