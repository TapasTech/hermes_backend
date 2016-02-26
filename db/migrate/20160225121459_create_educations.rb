class CreateEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :educations do |t|
      t.references :user, foreign_key: true
      t.string :organization
      t.string :direction

      t.timestamps
    end
    add_index :educations, :organization
    add_index :educations, :direction
  end
end
