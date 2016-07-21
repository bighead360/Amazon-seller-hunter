class ChangeColumnNameForBook < ActiveRecord::Migration
  def change
  	rename_column :books, :type, :cover_type
  	rename_column :books, :name, :titler
  end
end
