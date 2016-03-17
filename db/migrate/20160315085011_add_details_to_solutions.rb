# frozen_string_literal: true
class AddDetailsToSolutions < ActiveRecord::Migration[5.0]
  def change
    add_reference :solutions, :user, foreign_key: true
  end
end
