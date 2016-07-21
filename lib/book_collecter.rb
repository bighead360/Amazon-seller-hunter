include AmazonHelper


module BookCollecter
  class BookCollecterError < StandardError
  end
  def self.collect_price(item)
  
    listPrice = ""
    listPrice = item['ItemAttributes']['ListPrice']['Amount'] unless item['ItemAttributes']['ListPrice'].nil?
    price = item['Offers']['Offer']['OfferListing']['Price']['Amount']
    return price,listPrice
  end
  
  def self.collect(item)
    # if item['ItemAttributes'] == nil 
    #   item = item[0]
    #   puts "not one item"
    # end

    title = item['ItemAttributes']['Title'] 

    author = item['ItemAttributes']['Author']
    cover_image = item['LargeImage']['URL']
    target = ["Paperback", "Hardcover", "Diary", "Mass_Market_Paperback"]
    cover_type = item['ItemAttributes']['Binding'].split(' ').join('_')
    if target.exclude? cover_type
      cover_type = "other"
    end
    isbn = item['ItemAttributes']['ISBN']
    pages = item['ItemAttributes']['NumberOfPages']
    languagelist = []
    languagelist = languagelist.push(item['ItemAttributes']['Languages']['Language']).flatten
    language = languagelist[0]['Name']
    listPrice = ""
    listPrice = item['ItemAttributes']['ListPrice']['Amount'] unless item['ItemAttributes']['ListPrice'].nil?
    
    publisher = item['ItemAttributes']['Publisher']
    weight = item['ItemAttributes']['PackageDimensions']['Weight']["__content__"]
    price = item['Offers']['Offer']['OfferListing']['Price']['Amount']
    
    offerURL = item['Offers']['MoreOffersUrl']
    description = ""
    if /EditorialReviews/.match(item.to_s)
      reviewlist = []
      reviewlist = reviewlist.push(item['EditorialReviews']['EditorialReview']).flatten
      reviewlist.each do |review|
        if review['Source'] = "Product Description"
          description = review['Content'].to_s
        end
      end
    end
    tags =[]
    taglist = []
    taglist = taglist.push(item['BrowseNodes']['BrowseNode']).flatten
    taglist.first(5).each do |tag|
      tags << tag['Name']
    end
    tags = tags.join(',')

    # [title,cover_image,author,description, pages,publisher,language,listPrice,price,offerURL,weight,tags,cover_type,isbn].each do |option|
    #     if option == nil
    #       puts "wrong"
    #       option = "XX"
    #     end
    # end
    
    puts "#{item['ItemAttributes']['Title']}, #{cover_type}"
    return Bookget.new(title:title,cover_image:cover_image,author:author,description:description, pages:pages,publisher:publisher,language:language,listPrice:listPrice,price:price,offerURL:offerURL,weight:weight,tags:tags,cover_type:cover_type,isbn:isbn,condition:nil)
  end

end
