class VacuumX

	def initialize(marketplace='US')

		@request = Vacuum.new(marketplace)

    	@request.configure(
	      aws_access_key_id: 'AKIAJCJ5T2QSY2FHSFUA',
	      aws_secret_access_key: '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',
	      associate_tag: 'bighead360-20'
	    )
	end

	def item_lookup(isbn,condition)
		begin
			# byebug
			@request.item_lookup(
		      query: {
		      	'IdType'=> "ISBN",
		        'ItemId' => isbn,
		        'Condition' => condition,
		        'SearchIndex' => "Books",
		        'ResponseGroup' => "BrowseNodes,EditorialReview,Images,ItemAttributes,OfferListings"
		    })

		rescue Excon::Errors::ServiceUnavailable

			# TODO: handle difference exception 
			puts "Excon::Errors::ServiceUnavailable"
			puts "Request too fast, sleep 5 seconds"
			return nil
		end
	end

	def get_product_record(isbn)
		begin
			response = @request.item_lookup(
		      query: {
		        'ItemId' => isbn,
		        'ResponseGroup' => "ItemAttributes, Images, Reviews, SalesRank"
		    })
	    rescue Excon::Errors::ServiceUnavailable
			puts "Excon::Errors::ServiceUnavailable"
			puts "Request too fast, sleep 5 seconds"
			sleep(5)
			return nil
		end

		hashed_products = response.to_h
	end

end
