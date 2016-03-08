class AddConfidenceToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :confidence, :float
    add_index :users, :confidence
  end
end
