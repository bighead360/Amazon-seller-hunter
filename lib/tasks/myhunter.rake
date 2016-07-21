namespace :myhunter do
  desc "ProtoBook call Hunter"
  task protobookCallHunter: :environment do
  	ProtoBook.all.each do |protobook|
  		protobook.bsin.split('-').each do |book|
  			['Used','New'].each do |condition|
		  		@hunter = Hunter.find_or_create_by({ isbn: book, condition: condition})
		  		# @hunter.save
		  		# byebug
		  		if @hunter.book == nil && @hunter.status != "failed" && book !="0679429220"
			  		@hunter.start_hunt_book
			  		puts "The #{condition} book of #{book} is huntered!!"
			  	else
			  		puts "The #{condition} book of #{book} is exist!!"
		  		end
		  	
	  		end
	  	end 
  	end
	end


	desc "ProtoBook call Hunter"
  task debugCallHunter: :environment do
  	Hunter.where(status:3).each do |hunter|
  	#Hunter.where(isbn:"0739401912").each do |hunter|
  		if hunter.book == nil 
  			hunter.start_hunt_book
  			puts "The #{hunter.condition} book of #{hunter.isbn} is huntered!!"
  		else
  			puts "The #{hunter.condition} book of #{hunter.isbn} is exist!!"
  		end
  	end
	end


	desc "update Hunter price"
  task updatePrice: :environment do
  	Hunter.where(status:2).first(40).each do |hunter|
  	#Hunter.where(isbn:"0739401912").each do |hunter|
  		if hunter.book
  			prevPrice = hunter.book.price
  			
  			hunter.update_book_price
  			priceOffset = hunter.book.price.to_i - prevPrice.to_i
  			puts "The #{hunter.condition} book of #{hunter.isbn} is huntered!! price offset: #{priceOffset}"
  		else
  			puts "The #{hunter.condition} book of #{hunter.isbn} is not exist!!"
  		end
  	end
	end



	desc "write to Excel"
  task writeExcel: :environment do
	workbook = WriteExcel.new('ruby.xls')

	# Add worksheet(s)
  worksheet  = workbook.add_worksheet
  

# Add and define a format
# format = workbook.add_format
# format.set_bold
# format.set_color('red')
# format.set_align('right')

# write a formatted and unformatted string.

# write header 
header = ["Handle", "Title", "Body (HTML)","Vendor","Type","Tags","Published","Option1 Name","Option1 Value","Option2 Name","Option2 Value","Option3 Name","Option3 Value","Variant","SKU","Variant Grams","Variant Inventory Tracker","Variant Inventory Qty","Variant Inventory Policy","Variant Fulfillment Service","Variant Price","Variant Compare At Price","Variant Requires Shipping","Variant Taxable","Variant Barcode","Image Src","Image Alt Text","Gift Card","Google Shopping / MPN","Google Shopping / Age Group","Google Shopping / Gender","Google Shopping / Google Product Category","SEO Title","SEO Description","Google Shopping / AdWords Grouping","Google Shopping / AdWords Labels","Google Shopping / Condition","Google Shopping / Custom Product","Google Shopping / Custom Label 0","Google Shopping / Custom Label 1","Google Shopping / Custom Label 2","Google Shopping / Custom Label 3","Google Shopping / Custom Label 4","Variant Image","Variant Weight Unit"]
# "Handle"  "Title" "Body (HTML)" Vendor  Type  Tags  Published Option1 Name  Option1 Value Option2 Name  Option2 Value Option3 Name  Option3 Value Variant SKU Variant Grams Variant Inventory Tracker Variant Inventory Qty Variant Inventory Policy  Variant Fulfillment Service Variant Price Variant Compare At Price  Variant Requires Shipping Variant Taxable Variant Barcode Image Src Image Alt Text  Gift Card Google Shopping / MPN Google Shopping / Age Group Google Shopping / Gender  Google Shopping / Google Product Category SEO Title SEO Description Google Shopping / AdWords Grouping  Google Shopping / AdWords Labels  Google Shopping / Condition Google Shopping / Custom Product  Google Shopping / Custom Label 0  Google Shopping / Custom Label 1  Google Shopping / Custom Label 2  Google Shopping / Custom Label 3  Google Shopping / Custom Label 4  Variant Image Variant Weight Unit 
header.each_with_index do |head, index|
  worksheet.write(0, index, head)
end


index = 0
ProtoBook.all.each do |p_book|
   # puts "#{hunter.book.handle}, #{index}" 
   # puts "#{hunter.id}, #{index}"
	 
   # TODO: grape the common information of books to ProtoBook
   # Or find a new book variant from four potient books, and grape the data.
   # Initial the common data of the books 
   	    
   p_book.bsin.split('-').each do |isbn|
   	 hunterlist = []
   	 hunters = []
   	 hunters = Hunter.where(isbn: isbn)
   	 
   	 hunterlist = hunterlist.push(hunters).flatten
   	 
   
   	 hunterlist.each do |hunter|
	   	 if hunter.status == "finished" 
		   	 
		   	 # handle
		   	 worksheet.write(index + 1, 0, p_book.bsin)
			   
			   # title
			   worksheet.write(index + 1, 1, hunter.book.title)
			   puts "The #{index} book #{isbn} is written!!"
			   # body(html)
			   worksheet.write(index + 1, 2, hunter.book.description)
			   
			   # vendor
			   worksheet.write(index + 1, 3, hunter.book.publisher)
			  
			   # product type 
			   worksheet.write(index + 1, 4, "Books")
			   
			   # tags 
			   worksheet.write(index + 1, 5, hunter.book.tags)
			   
			   # published ?
			   worksheet.write(index + 1, 6, "TRUE")

			   # image src  
			   worksheet.write(index + 1, 25, hunter.book.cover_image)

			   # image alt Text 
			   worksheet.write(index + 1, 26, hunter.book.title)

			   # Gift Card 
			   worksheet.write(index + 1, 27, "False")

			   # ----------- Variant Option Start -------------
			   # variant Option1 Name 
			   worksheet.write(index + 1, 7, "Type")
			   
			   # variant Option1 Value 
			   worksheet.write(index + 1, 8, "#{hunter.book.cover_type} #{hunter.book.condition}")

			   # variant SKU
			   worksheet.write(index + 1, 14, "#{isbn}-#{hunter.book.condition}")

			   # variant grams 
			   var_grams = ((hunter.book.weight.to_f)/100.pound.to.gram).to_i 

			   worksheet.write(index + 1, 15, var_grams)
			   
			   # variant inventory Qty
			   worksheet.write(index + 1, 17, 5) # how to confirm the stock 10 or 0
			   
			   # variant inventory policy 
			   worksheet.write(index + 1, 18, "deny")

			   # variant fullfill service
			   worksheet.write(index + 1, 19, "manual")
			   
			   # variant price 
			   var_price = (hunter.book.price.to_f/100 + 8).round(2)
			   var_price = var_price.ceil-0.01
			   if hunter.book.listPrice.to_f/100 * 0.6 > var_price
			   	var_price = hunter.book.listPrice.to_f/100 * 0.6
			   	var_price = var_price.ceil-0.01
			   end

			   worksheet.write(index + 1, 20, var_price) 
			
				 # variant compare price (listing price)
				if hunter.book.listPrice != "" && (hunter.book.listPrice.to_f/100) > var_price 
				 var_listing_price = hunter.book.listPrice.to_f/100
				 worksheet.write(index + 1, 21, var_listing_price)#TODO
				end

				 # variant request shipping 
			   worksheet.write(index + 1, 22, "TRUE")

			   # variant taxable 
			   worksheet.write(index + 1, 23, "TRUE")

			   # variant barcode (isbn)
			   worksheet.write(index + 1, 23, isbn)

			   # ----------- Variant Option End -------------

			   index = index + 1
			   
			   

			 end
		 end

   end




end
# worksheet.write(1, 1, 'Hi Excel.', format)  # cell B2
# worksheet.write(2, 1, 'Hi Excel.')          # cell B3

# write a number and formula using A1 notation
# worksheet.write('B4', 3.14159)
# worksheet.write('B5', '=SIN(B4/4)')

# write to file
workbook.close
end
end