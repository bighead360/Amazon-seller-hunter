class AddIndexToIsbn < ActiveRecord::Migration
  def change
  	add_index :isbns, [:isbn], unique: true
  end
end
