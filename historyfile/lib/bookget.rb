class Bookget
	attr_accessor :name ,:cover_image, :author,:description,:review, :series,:pages,:publisher, :language,:dimensions,:weight

	def initialize(name,cover_image,author,description,series,pages,publisher,language,dimensions,weight)
		@name = name
		@cover_image = cover_image
		@author = author
		@series = series
		@pages = pages
		@publisher = publisher
		@language = language
		@dimensions = dimensions
		@weight =weight
		@description =description
		

	end

end