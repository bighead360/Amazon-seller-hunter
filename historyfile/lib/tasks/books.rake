require 'webPage'
require "#{Rails.root}/app/helpers/amazon_helper"
include AmazonHelper

namespace :books do

	desc "Update all the books handle"
	task update_handle: :environment do
		puts "Test"
		Hunter.all.each do |hunter|
			b = ['a', 'the', 'to', 'an', 'for', 'from', 'on', 'at', 'in']
			hunter.book.handle =  (book.name.downcase.gsub(/[^a-z ]/,'').split - b).join('-')
			
			hunter.book.save!
		end

	end

	desc "Update all the books weight"
	task update_weight: :environment do
		puts "Test"
		Hunter.all.each do |hunter|
			b = ['a', 'the', 'to', 'an', 'for', 'from', 'on', 'at', 'in']
			hunter.book.handle =  (hunter.book.name.downcase.gsub(/[^a-z ]/,'').split - b).join('-')
			
			wei_arr = hunter.book.weight.split 
			gram = 0
			if wei_arr[1] == 'ounces'
				gram = wei_arr[0].to_f.ounce.to.gram.to_f.round(2)
			elsif wei_arr[1] == 'pounds'
				gram = wei_arr[0].to_f.pound.to.gram.to_f.round(2)
			end

			hunter.book.weight = gram

			hunter.book.save!
		end
	end


	desc "Remove the duplicate Hunter and Book Record"
	task create_parent_node: :environment do

		Isbn.all.each do |isbn|
			# Step 0, if this isbn already tracked. Performance
			# byebug
			if ProtoBook.where("bsin LIKE ?", "%#{isbn.isbn}%").count == 1 
				puts "#{isbn.isbn} already exisiting in the database"
				next
			end

			# Step 1, group the isbn 
			page = WebPage.safe_fetch( AmazonHelper::build_book_url(isbn.isbn) )

			if page == nil
				puts "Can't fetch the data from Amazon for #{isbn.isbn}!!" 
				next 
			end	

			target = ["Paperback", "Hardcover"]
			isbn_arr = [isbn.isbn]
			page.css("#tmmSwatches > ul > li.swatchElement.unselected").each do |item|
				type = item.css("a.a-button-text > span:nth-child(1)").text
				if target.include? type
					# byebug
					ii = item.css("a.a-button-text").attr('href').to_s
					isbn_arr << ii.split('/')[3]
				end
			end

			# Step 2, check if ProtoBook exsiting. 
			# If not, create ProtoBook, and assign the group of isbn to the ProtoBook
			# If yes, check if the ProtoBook has all the variants 
			
			bsin_id = isbn_arr.sort.join('-')
			p_book = ProtoBook.create(bsin: bsin_id)

			puts "ProtoBook #{bsin_id} is created!!!"
			# Step 3, save to database 
			p_book.save!
			# File.write('output.html', page.to_html)
		end

	end

end
