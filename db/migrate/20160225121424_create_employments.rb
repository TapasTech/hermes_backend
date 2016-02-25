class CreateEmployments < ActiveRecord::Migration[5.0]
  def change
    create_table :employments do |t|
      t.references :user, foreign_key: true
      t.string :employment
      t.string :position

      t.timestamps
    end
    add_index :employments, :employment
    add_index :employments, :position
  end
end
