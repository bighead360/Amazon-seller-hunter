class SellerHunter
  include AmazonHelper

  def self.perform(hunt_id)
    sleep 1
    setup_work(hunt_id)
    find_best_seller
    return unless (defined? @best_seller) && @best_seller
    finish_work
  end

  def self.update(hunt_id)
    sleep 1
    setup_work(hunt_id)
    find_best_seller
    # return unless (defined? @best_seller) && @best_seller
    update_work
  end

  private

  def self.setup_work(hunt_id)
    @hunter = Hunter.find(hunt_id)
    @hunter.update(status: :working)
  end

  def self.find_best_seller
    @thissellers = nil
  
    @thissellers = SellerCollecter.collect(isbn: @hunter.isbn, condition: 'new_book')
    
    @best_seller = nil
    @best_seller = RuleEngine.pick_best(@thissellers)
    
    @best_seller.seller_url = build_seller_product_url(@best_seller.amazon_id, @hunter.isbn)

    return @best_seller
    
  rescue StandardError => e
    @hunter.update(status: :failed)
  end

  def self.finish_work
     
    @seller = Seller.new
    @seller.seller_name = @best_seller.seller_name
    @seller.price = @best_seller.price
    @seller.shippingfee = @best_seller.shipping_fee
    @seller.seller_url = @best_seller.seller_url
    @seller.rate = @best_seller.rate
    @seller.total_ratings = @best_seller.total_ratings
    @seller.score = @best_seller.score
    @seller.amazon_id = @best_seller.amazon_id
    @seller.hunter_id = @hunter.id
    @seller.save
    @hunter.update(status: :finished)
  end

  def self.update_work  
    if @hunter.seller.nil?
      @seller = Seller.new
    else
      @seller = @hunter.seller
    end
    @seller.seller_name = @best_seller.seller_name
    @seller.price = @best_seller.price
    @seller.shippingfee = @best_seller.shipping_fee
    @seller.seller_url = @best_seller.seller_url
    @seller.rate = @best_seller.rate
    @seller.amazon_id = @best_seller.amazon_id
    @seller.total_ratings = @best_seller.total_ratings
    @seller.score = @best_seller.score
    @seller.save
    @hunter.update(status: :finished)
     
  end

end