class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|

      t.string :long
      t.string :latt
      t.timestamps
    end
  end
end
