module Rule

	def Rule.filter(getseller)
		
		filterInStock(getseller)||filterRate(getseller)||filterRatings(getseller)
			
	end

	def Rule.score(getseller)
    return getseller.price + getseller.shipping_fee if getseller.free_shipping_over.nil?
    return getseller.price if getseller.price > getseller.free_shipping_over
  end

  private

  def Rule.filterInStock(getseller)
  	
  	getseller.in_stock == false
  		

  end


  def Rule.filterRate(getseller)
  	
    getseller.rate <= 0.85
  
  end

  def Rule.filterRatings(getseller)
   	getseller.total_ratings <= 100
  end



end