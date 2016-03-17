class AddFolloweesCountToUsers < ActiveRecord::Migration

  def self.up

    add_column :users, :followees_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :followees_count

  end

end
