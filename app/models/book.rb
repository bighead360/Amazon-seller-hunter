class Book < ActiveRecord::Base
	belongs_to :hunter
	
	enum cover_type: [:Paperback, :Hardcover, :Diary, :Mass_Market_Paperback, :other]
	enum condition: [:New, :Used]

	def self.count_books
		@count = 1
		@exclusiveTitle = Book.first.title
    	Book.all.each do |book|
    		if @exclusiveTitle != book.title
    			@count = @count+1
    			@exclusiveTitle = book.title
    		end
    	end
    	return @count
  end
end
