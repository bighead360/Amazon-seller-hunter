

class BookHunter

	include AmazonHelper
	def self.perform(hunt_id)
    # byebug
    sleep 1
    setup_work(hunt_id)
    find_book
    finish_work
    # return unless (defined? @thisbook) && @thisbook
  end
  def self.update(hunt_id)
    sleep 1
    setup_work(hunt_id)
    find_book
    update_work
    # return unless (defined? @thisbook) && @thisbook
  end

  def self.update_price(hunt_id)
    sleep 1
    setup_work(hunt_id)
    find_price
    save_update_price
    # return unless (defined? @thisbook) && @thisbook
  end

  private

  def self.setup_work(hunt_id)
    @hunter = Hunter.find(hunt_id)
    # byebug
    @hunter.update(status: :working)
  end

  def self.find_price
    begin 
      @request = VacuumX.new # A customize class wrap the Vacuum 
      response = @request.item_lookup(@hunter.isbn, @hunter.condition)

      i = 0
      while response == nil 
        return false if i == 5 #try five times, if still not avaible, give up.
        i = i + 1
        deplay = 5 * i 
        sleep(deplay)
        puts_debug "Request too fast, sleep #{deplay} seconds, try #{i} time"
        response = @request.item_lookup(@hunter.isbn)
        hashed_products = response.to_h
      end 
     
      hashed_book = response.to_h
      
      item = hashed_book['ItemLookupResponse']['Items']['Item']
      
      item = item[0] unless item[0].nil?
     
      @priceCombo = nil
      @priceCombo = BookCollecter.collect_price(item)
    rescue StandardError => e
      puts "failed"
      @hunter.update(status: :failed )
    end
  end

  def self.find_book
    begin 
      @request = VacuumX.new # A customize class wrap the Vacuum 
      response = @request.item_lookup(@hunter.isbn, @hunter.condition)

      i = 0
      while response == nil 
        return false if i == 5 #try five times, if still not avaible, give up.
        i = i + 1
        deplay = 5 * i 
        sleep(deplay)
        puts_debug "Request too fast, sleep #{deplay} seconds, try #{i} time"
        response = @request.item_lookup(@hunter.isbn)
        hashed_products = response.to_h
      end 
     
      hashed_book = response.to_h
      
      item = hashed_book['ItemLookupResponse']['Items']['Item']
      
      item = item[0] unless item[0].nil?
     
      @thisbook = nil
      @thisbook = BookCollecter.collect(item)
      
      @thisbook.condition = @hunter.condition
      
    rescue StandardError => e
      puts "failed"
      @hunter.update(status: :failed )
    end
  end

# update price
  def self.save_update_price
    if @priceCombo
      
      @hunter.book.price = @priceCombo[0]
      @hunter.book.listPrice = @priceCombo[1]
      @hunter.book.save
      puts "#{@hunter.book.title}, #{@hunter.book.price} update!!"
      @hunter.update(status: :finished)  
    end
  end

  def self.finish_work
    
  	@book = Book.new
    if @thisbook 
      setBookValue
      @book.hunter_id = @hunter.id
      @book.save
      puts "#{@book.title}, #{@book.condition}!!"
      @hunter.update(status: :finished)  
    end
	end

  # def self.update_work
  #   if @hunter.book.nil?
  #     @book =Book.new
  #   else
  #     @book = @hunter.book
  #   end
  #   giveBookValue
    
  #   @book.save
  #   @hunter.update(status: :finished)  
  # end

  def self.setBookValue
    # byebug
    @book.title = @thisbook.title
    @book.cover_image = @thisbook.cover_image
    @book.author = @thisbook.author
   # book.series = thisbook.series
    @book.description = @thisbook.description
    @book.pages = @thisbook.pages
    @book.publisher = @thisbook.publisher
    @book.language = @thisbook.language
  #book.dimensions = @thisbook.dimensions
    @book.weight = @thisbook.weight
    #new attr
    @book.price = @thisbook.price
    @book.listPrice = @thisbook.listPrice
    @book.offerURL = @thisbook.offerURL
    @book.tags = @thisbook.tags
    @book.isbn = @thisbook.isbn
    @book.cover_type = @thisbook.cover_type
    @book.condition = @thisbook.condition
    # byebug

  end
end


