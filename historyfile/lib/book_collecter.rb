require 'rest-client'
require 'nokogiri'
require 'webPage'
include AmazonHelper


module BookCollecter
  class BookCollecterError < StandardError
  end

  module BookParser

     def self.parse(book_html_element)
      name = book_html_element.xpath('//*[@id="productTitle"]').text
      cover_image =book_html_element.css('#imgBlkFront').attr('data-a-dynamic-image').value.split('"')[1]
      author = book_html_element.xpath('//*[@id="byline"]/span/span[1]/a[1]').text
      # scripts = book_html_element.css('script').text
      # iframeContent = scripts.scan(/var iframeContent = \"/).first
      # dd = scripts.split(iframeContent)[1]
      # reviewcontnent = dd.split('"')[0]
      # reviewcontnent = decode(reviewcontnent).split('<body>')[1].split('</body>')[0]
      productDetails = book_html_element.css('div.content>ul>li')
          series = nil
          pages = nil
          pages = nil
          publisher = nil
          language  = nil
          dimensions = nil
          weight = nil
      productDetails.each do |productDetail|

        series ||= judgedetail(productDetail,"Series")
        pages  ||= judgedetail(productDetail,"Paperback")
        pages  ||= judgedetail(productDetail,"Hardcover")
        publisher ||= judgedetail(productDetail,"Publisher")
        language  ||= judgedetail(productDetail,"Language")
        dimensions ||= judgedetail(productDetail,"Dimensions")
        weight ||= judgedetail(productDetail,"Weight")
          
      end
   
      description = book_html_element.css('#bookDescription_feature_div noscript').to_html.split("<noscript>").join("").split("</noscript>").join("")
      
      return Bookget.new(name,cover_image,author,description,series,pages,publisher,language,dimensions,weight.tr('()', ''))
    end

    def self.judgedetail(productDetail,detailname)
      productDetail.xpath('text()').text unless /#{detailname}/.match(productDetail.css('b').text).nil?
    end
  end

  def self.collect(isbn: nil, condition: nil)
    include WebPage
    amazon_book_url = build_book_url(isbn)
    page = WebPage.getWebPge(amazon_book_url)
    return BookParser.parse(page)
  end
end
