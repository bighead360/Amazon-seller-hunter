class AddProtoBooksRefToBooks < ActiveRecord::Migration
  def change
  	add_reference :books, :proto_book, index: true, foreign_key: true
  end
end
