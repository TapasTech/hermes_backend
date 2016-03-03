class AddUserToDataSet < ActiveRecord::Migration[5.0]
  def change
    add_reference :data_sets, :user, foreign_key: true
  end
end
