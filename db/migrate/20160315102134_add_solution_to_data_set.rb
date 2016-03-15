# frozen_string_literal: true
class AddSolutionToDataSet < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_sets, :solution, index: true, foreign_key: true
  end
end
