class CreateBookshops < ActiveRecord::Migration
  def change
    create_table :bookshops do |t|
      t.string :shopname

      t.timestamps null: false
    end
  end
end
