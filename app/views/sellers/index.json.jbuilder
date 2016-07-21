json.array!(@sellers) do |seller|
  json.extract! seller, :id, :seller_name, :price, :prime, :rate, :total_ratings, :in_stock, :shippingfee, :ship_from, :score, :free_shipping
  json.url seller_url(seller, format: :json)
end
