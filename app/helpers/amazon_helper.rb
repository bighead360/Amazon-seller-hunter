module AmazonHelper

  def get_isbn_from_url(url)
    url.split('dp/')[1]
  end 

  def build_book_url(isbn)
    "http://www.amazon.com/dp/#{isbn}"
  end

  def build_offer_list_url(isbn,condition)
    "http://www.amazon.com/gp/offer-listing/#{isbn}/ref=olp_tab_new?ie=UTF8&condition=#{condition.to_s.split('_')[0]}"
  end

  def build_seller_product_url(seller_id, isbn)
   
    "https://www.amazon.com/dp/#{isbn}?m=#{seller_id}&ref_=v_sp_widget_detail_page"
  end

  def build_shop_url(seller_id, page ,keyword)
    "https://www.amazon.com/s/ref=sr_pg_#{page}?me=#{seller_id}&rh=k%3Ae&page=#{page}&keywords=#{keyword}"
  end
#{}"https://www.amazon.com/s/ref=sr_pg_#{page}?me=#{seller_id}&rh=i%3Amerchant-items&page=#{page}"

  

end