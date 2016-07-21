require 'writeexcel'

namespace :mybatchwork do

  desc "ISBN call Hunter"
  task isbnCallHunter: :environment do
  	Isbn.all.each do |isbn|
  		@hunter = Hunter.new
  		@hunter.isbn = isbn.isbn
  		@hunter.condition = 'new_book'
  		@hunter.save
  end
end

 desc "update isbn"
  task updateIsbn: :environment do
    Bookshop.first.start_hunt_isbn
  
end


  desc "update Seller info"
  task updateSeller: :environment do
	
  	Hunter.first(6).each do |hunter|
  		hunter.update_hunt_book
  		hunter.update_hunt_seller
  	
  end
end

desc "update all failed"
  task updateFailed: :environment do
  
    Hunter.failed.each do |hunter|
      hunter.update_hunt_book
      hunter.update_hunt_seller
    
  end
end

desc "fixbug"
task updateTarget: :environment do
      #Hunter.find(440).update_hunt_book
      Hunter.find(445).update_hunt_seller 
end

 desc "update Book info"
  task updateBook: :environment do
	
  	Hunter.all.each do |hunter|
  		
  		hunter.update_hunt_book
  	
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



Hunter.finished.each_with_index do |hunter, index|
   puts "#{hunter.book.handle}, #{index}" 
   puts "#{hunter.id}, #{index}"
    
   worksheet.write(index + 1, 0, hunter.book.handle)
   worksheet.write(index + 1, 1, hunter.book.name)
   worksheet.write(index + 1, 2, hunter.book.description)
   worksheet.write(index + 1, 3, hunter.book.publisher)
   
   worksheet.write(index + 1, 6, "TRUE")
   worksheet.write(index + 1, 14, hunter.book.handle)
   worksheet.write(index + 1, 15, hunter.book.weight)
   worksheet.write(index + 1, 17, "10 or 0")
   worksheet.write(index + 1, 18, "deny")
   worksheet.write(index + 1, 19, "manual")
   worksheet.write(index + 1, 20, (hunter.seller.price + hunter.seller.price*0.2+3.99).round(2)) unless hunter.seller.nil?
   worksheet.write(index + 1, 22, "TRUE")
   worksheet.write(index + 1, 23, "TRUE")
   worksheet.write(index + 1, 25, hunter.book.cover_image)
   worksheet.write(index + 1, 26, hunter.book.name)
   worksheet.write(index + 1, 27, "False")



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
