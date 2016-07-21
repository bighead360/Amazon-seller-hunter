require 'bookhunter'
require 'sellerhunter'

class Hunter < ActiveRecord::Base

	enum condition: [:New, :Used]
  enum status: [:pending, :working, :finished, :failed]
  has_one :book, dependent: :destroy
  has_one :seller, dependent: :destroy

  # validates :isbn, format: {
  #   with: /\A(\d{3}-)?\d{10}\z/,
  #   message: 'only allows ISBN-13 or ISBN-10'
  # }
  after_initialize :default_values
  #after_create :start_hunt_book , :start_hunt_seller

  def update_hunt_book
    BookHunter.update(self.id)
  end

  def update_book_price
    BookHunter.update_price(self.id)
  end

  def default_values
    self.status ||=  :pending
  end

  def start_hunt_book
    BookHunter.perform(self.id)
  end
 
  def start_hunt_seller
    SellerHunter.perform(self.id)
  end
  
end
