class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :display_name
      t.string :gender
      t.references :business, foreign_key: true

      t.timestamps
    end
  end
end
