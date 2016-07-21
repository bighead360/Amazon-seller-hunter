require 'vacuum'


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

  private

  def self.setup_work(hunt_id)
    @hunter = Hunter.find(hunt_id)
    @hunter.update(status: :working)
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
      book = hashed_book['ItemLookupResponse']['Items']['Item']
      @thisbook = BookCollecter.collect(book)
    rescue StandardError => e
      @hunter.update(status: :failed )
    end
  end

  def self.finish_work
    # byebug
  	@book = Book.new
    if @thisbook 
      giveBookValue(@book, @thisbook)
      @book.hunter_id = @hunter.id
      @book.save
      @hunter.update(status: :finished)  
    end
	end

  def self.update_work
    if @hunter.book.nil?
      @book =Book.new
    else
      @book = @hunter.book
    end
    
    giveBookValue(@book, @thisbook)
    @book.save
    @hunter.update(status: :finished)  
  end

  def self.giveBookValue(book,giverbook)

    book.name = giverbook.name
    book.cover_image = giverbook.cover_image
    book.author = giverbook.author
    book.series = giverbook.series
    book.description = giverbook.description
    book.pages = giverbook.pages
    book.series = giverbook.series
    book.publisher = giverbook.publisher
    book.language = giverbook.language
    book.dimensions = giverbook.dimensions
    book.weight = giverbook.weight
  end
end


