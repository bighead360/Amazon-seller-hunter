class CreateHunters < ActiveRecord::Migration
  def change
    create_table :hunters do |t|
      t.string :isbn
      t.integer :condition
      t.integer :status

      t.timestamps null: false
    end
  end
end
