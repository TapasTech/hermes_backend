# frozen_string_literal: true
class AddUserToDataReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_reports, :user, foreign_key: true
  end
end
