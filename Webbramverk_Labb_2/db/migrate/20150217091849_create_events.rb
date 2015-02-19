class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.references :position
      t.references :creator
      t.string :description
      t.timestamps
    end
  end
end
