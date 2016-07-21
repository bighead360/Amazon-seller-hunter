class AddAmazonidToBookshop < ActiveRecord::Migration
  def change
    add_column :bookshops, :Amazonid, :string
  end
end
