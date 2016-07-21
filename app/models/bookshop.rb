require 'IsbnHunter'
class Bookshop < ActiveRecord::Base
	has_many :isbn, dependent: :destroy
	after_create :start_hunt_isbn

	
	
  def start_hunt_isbn
    IsbnHunter.perform(id)
  end

end
