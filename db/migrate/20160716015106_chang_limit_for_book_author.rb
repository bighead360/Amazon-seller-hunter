class ChangLimitForBookAuthor < ActiveRecord::Migration
  def change
  	change_column :books, :author, :string, :limit => 510
  end
end
