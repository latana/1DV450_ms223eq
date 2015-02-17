class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|

      t.string :user
      t.timestamps
    end
  end
end
