class AddSellerUrlToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :seller_url, :string
  end
end
