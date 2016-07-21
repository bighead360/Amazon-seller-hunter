class AddAmazonidToSeller < ActiveRecord::Migration
  def change
    add_column :sellers, :amazon_id, :string
  end
end
