# frozen_string_literal: true
class AddDeletedAtToDataReports < ActiveRecord::Migration[5.0]
  def change
    add_column :data_reports, :deleted_at, :datetime
    add_index :data_reports, :deleted_at
  end
end
