# frozen_string_literal: true
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :display_name
      t.text :gender
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
