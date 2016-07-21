class AddDimensionsToBook < ActiveRecord::Migration
  def change
    add_column :books, :dimensions, :string
  end
end
