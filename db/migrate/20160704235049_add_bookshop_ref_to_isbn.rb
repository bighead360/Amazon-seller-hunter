class AddBookshopRefToIsbn < ActiveRecord::Migration
  def change
    add_reference :isbns, :Bookshop, index: true, foreign_key: true
  end
end
