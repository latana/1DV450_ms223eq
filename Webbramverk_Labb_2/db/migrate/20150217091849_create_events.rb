class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.references :position
      t.references :creator
      t.timestamps
    end
  end
end
