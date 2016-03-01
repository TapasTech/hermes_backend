class AddHotToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :hot, :float
    add_index :questions, :hot
  end
end
