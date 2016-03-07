# frozen_string_literal: true
class AddDescriptionToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :text
  end
end
