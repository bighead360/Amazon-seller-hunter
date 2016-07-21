class ChangeLimitForBookTitle < ActiveRecord::Migration
  def change
  	change_column :books, :title, :string, :limit => 510
  end
end
