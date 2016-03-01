class AddConfidenceToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :confidence, :float
    add_index :answers, :confidence
  end
end
