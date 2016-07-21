require 'rest-client'
require 'nokogiri'
require 'webPage'
include AmazonHelper

module SellerCollecter
  class SellerCollecterError < StandardError
  end

  module SellerParser
    def self.parse(seller_html_element)
      
      flag_seller_is_amazon = seller_html_element.css('div.a-column.a-span2.olpSellerColumn > h3 > img').count > 0
      seller_name = flag_seller_is_amazon ? 'amazon.com' : seller_html_element.css('div.a-column.a-span2.olpSellerColumn > h3 > span > a').first.text
      amazon_id = flag_seller_is_amazon ? 'ATVPDKIKX0DER' : seller_html_element.css('div.a-column.a-span2.olpSellerColumn > h3 > span > a').first['href'].split('=').last
      price = seller_html_element.css('div:nth-child(1) > span').first.text.strip[1..-1].to_f
      price ||= 9999
      prime = !seller_html_element.css('div:nth-child(1) > span.supersaver > i > span').empty?
     
      shipping_fee = 3.99 if prime
      shipping_fee ||= 0 unless /FREE Shipping/.match(seller_html_element.css('div:nth-child(1) > p > span > b').text).nil?
      shipping_fee ||= seller_html_element.css('div:nth-child(1) > p > span > span.olpShippingPrice').first.text.strip[1..-1].to_f
      free_shipping_over = nil
      rate,total_ratings = 0,0 unless /Just Launched/.match(seller_html_element.css('b.olpJustLaunched').text).nil?
      rate ||= flag_seller_is_amazon ? 1 : seller_html_element.css('div.a-column.a-span2.olpSellerColumn > p > a > b').first.text.split('%').first.to_f / 100
      total_ratings ||= flag_seller_is_amazon ? Float::INFINITY : /\((\d+(?:,\d+)*) (?:rating|total ratings)\)/.match(seller_html_element.css('div.a-column.a-span2.olpSellerColumn > p').first.text)[1].split(',').join('').to_i
      
     
      in_stock = true
      if flag_seller_is_amazon
        ships_from = 'United States'
      else

        ships_from = ''
        # m = /Ships from (.*?)\./.match(seller_html_element.css('div.a-column.a-span3.olpDeliveryColumn > ul > li:nth-child(2) > span').first.text)
                           

        # if m
        #   ships_from = m[1]
        # else
        #   ships_from = ''
        # end
      end
      
      Getseller.new(seller_name, amazon_id, price, shipping_fee, prime, free_shipping_over, rate, total_ratings, in_stock, ships_from, nil)
      
    end
  end

  def self.collect(isbn: nil, condition: nil)
    include AmazonHelper
    amazon_offer_list_url = build_offer_list_url(isbn, condition)
    page = WebPage.getWebPge(amazon_offer_list_url)
    seller_html_elements = page.css('div.olpOffer')
    this_seller_html_elements = seller_html_elements.map { |seller_html_element| SellerParser.parse(seller_html_element) }
    
    return this_seller_html_elements
    
  end
end
