class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string 'email', :unique => true
      t.string 'password', :limit => 50
      t.string 'key', :unique => true
      t.boolean 'admin', default: false
      t.timestamps
    end
  end
end
