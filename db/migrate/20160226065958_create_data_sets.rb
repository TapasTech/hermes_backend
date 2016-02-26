class CreateDataSets < ActiveRecord::Migration[5.0]
  def change
    create_table :data_sets do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
    add_index :data_sets, :url
  end
end
