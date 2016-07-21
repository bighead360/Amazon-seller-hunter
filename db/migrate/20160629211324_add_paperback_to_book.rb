class AddPaperbackToBook < ActiveRecord::Migration
  def change
    add_column :books, :paperback, :string
  end
end
