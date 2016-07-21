class Bookget
	attr_accessor :title ,:cover_image, :author,:description,:pages,:publisher, :language,:weight,:tags,:offerURL,:price,:listPrice,:cover_type,:isbn,:condition

	def initialize(title:title,cover_image:cover_image,author:author,description:description, pages:pages,publisher:publisher,language:language,listPrice:listPrice,price:price,offerURL:offerURL,weight:weight,tags:tags,cover_type:cover_type,isbn:isbn,condition:condition)
		@title = title
		@cover_image = cover_image
		@author = author
		@pages = pages
		@publisher = publisher
		@language = language
		@weight =weight
		@description =description
		@tags = tags
		@price = price
		@listPrice = listPrice
		@cover_type = cover_type
		@offerURL = offerURL
		@isbn = isbn
		@condition =condition
		

	end

end