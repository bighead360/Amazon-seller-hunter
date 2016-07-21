class Getseller
  include Comparable
  attr_accessor :name, :id, :price, :shipping_fee, :prime, :free_shipping_over, :rate, :total_ratings, :in_stock, :ships_from, :seller_url, :score

  def initialize(seller_name, amazon_id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from , seller_url)

    @seller_name = seller_name
    @amazon_id = amazon_id
    @price = price
    @shipping_fee = shipping_fee
    @prime = prime
    @free_shipping_over = free_shipping_over
    @rate = rate
    @total_ratings = total_ratings
    @in_stock = in_stock
    @ships_from = ships_from
    @seller_url = seller_url
    @score = 100
  end

  def seller_name
    @seller_name
  end

  def price
    @price
  end

  def shipping_fee
    @shipping_fee
  end

  def amazon_id
    @amazon_id
  end

   def seller_url
    @seller_url
  end



  def <=>(other)
    other.score <=> @score
  end
end