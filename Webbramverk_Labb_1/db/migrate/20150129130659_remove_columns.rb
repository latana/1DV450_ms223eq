class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :key
  end
end
