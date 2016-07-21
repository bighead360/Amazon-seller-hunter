class CreateProtoBooks < ActiveRecord::Migration
  def change
    create_table :proto_books do |t|
      t.string :bsin
      t.timestamps null: false
    end
    remove_column :books, :ProtoBook_id
  end
end
