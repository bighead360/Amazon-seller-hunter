class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :seller_name
      t.decimal :price, :precision => 8, :scale => 2
      t.boolean :prime
      t.decimal :rate, :precision => 5, :scale => 2
      t.integer :total_ratings
      t.boolean :in_stock
      t.decimal :shippingfee, :precision => 4, :scale => 2
      t.string :ship_from
      t.decimal :score
      t.boolean :free_shipping

      t.timestamps null: false
    end
  end
end
