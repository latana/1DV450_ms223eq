class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|

      # precision = max siffror
      # Scare = hur många som skrivs ut
      t.float :long, :precision => 10, :scale => 6
      t.float :latt, :precision => 10, :scale => 6
      t.timestamps
    end
  end
end
