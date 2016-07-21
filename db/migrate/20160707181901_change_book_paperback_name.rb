class ChangeBookPaperbackName < ActiveRecord::Migration
  def change
  	rename_column :books, :paperback, :pages
  end
end
