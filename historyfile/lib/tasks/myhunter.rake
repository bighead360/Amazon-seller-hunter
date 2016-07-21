namespace :myhunter do
  desc "ProtoBook call Hunter"
  task protobookCallHunter: :environment do
  	ProtoBook.first(5).each do |protobook|
  		protobook.bsin.split('-').each do |book|
  			['new_book', 'used_book'].each do |condition|
		  		@hunter = Hunter.find_or_create_by({ isbn: book, condition: condition })
		  		# @hunter.save
		  		puts "The #{condition} book of #{book} is huntered!!"
	  		end
	  	end 
  	end
	end
end