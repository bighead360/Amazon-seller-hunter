class AddWeightToBook < ActiveRecord::Migration
  def change
    add_column :books, :weight, :string
  end
end
