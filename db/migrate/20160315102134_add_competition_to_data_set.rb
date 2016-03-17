# frozen_string_literal: true
class AddCompetitionToDataSet < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_sets, :competition, index: true, foreign_key: true
  end
end
