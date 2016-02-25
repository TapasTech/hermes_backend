class CreateBusinesses < ActiveRecord::Migration[5.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.integer :parent_business_id

      t.timestamps
    end
    add_index :businesses, :name
    add_index :businesses, :parent_business_id
    add_foreign_key(:businesses, :businesses, column: :parent_business_id, primary_key: :id)
  end
end
