require 'rest-client'
require 'nokogiri'
include AmazonHelper
class IsbnHunter


	def self.perform(bookshop_id)
    sleep 1
    setup_work(bookshop_id)
    keywords = "abcd"
    #keywords = "q"
    chars = keywords.split('')
    #chars = ["god"]
    chars.each{|c|
      @emptypage = false
      @b = 1
    while @emptypage == false do
      collect(@bookshop.Amazonid,@b,c )
      @b+=1
    end
 
    }
   
  end
  

  private

  def self.setup_work(bookshop_id)
    @bookshop = Bookshop.find(bookshop_id)
end

  def self.collect(seller_id,page,keyword)
  	
  	page = page.to_s
    shop_url = build_shop_url(seller_id, page, keyword)
    begin
      tries ||= 10
      page_html = RestClient.get shop_url, user_agent: 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0'
    rescue RestClient::ServiceUnavailable
      sleep 1
      tries -= 1
      if tries > 0
        retry
      else
        raise SellerCollecterError, 'can not get the list page'
      end
    end
    htmlpage = Nokogiri::HTML(page_html)
    @i = (page.to_i-1)*24
    
    listblock = htmlpage.xpath("//*[@id='s-results-list-atf']")
     
       @emptypage = true if listblock.empty?
    

    while (htmlpage.xpath("//*[@id='result_#{@i}']").present? ) do
    	getisbn = htmlpage.xpath("//*[@id='result_#{@i}']")
    	@isbn = Isbn.new
    	@isbn.isbn = getisbn.attr('data-asin')
      @isbn.Bookshop_id = @bookshop.id
    	@isbn.save
 		  @i += 1
	end
    
  end

end