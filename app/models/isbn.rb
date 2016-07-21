class Isbn < ActiveRecord::Base
	belongs_to :bookshop
	validates :isbn, presence: true, uniqueness: true
end
