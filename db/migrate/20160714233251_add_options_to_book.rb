class AddOptionsToBook < ActiveRecord::Migration
  def change
  	add_column :books, :condition, :integer
  	add_column :books, :offerURL, :string
  	add_column :books, :tags, :string
  	add_column :books, :price, :string
  	add_column :books, :listPrice, :string
  end
end
