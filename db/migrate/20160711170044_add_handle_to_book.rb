class AddHandleToBook < ActiveRecord::Migration
  def change
  	add_column :books, :handle, :string, unique: true
  end
end
