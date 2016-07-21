describe Hunter do 
	it 'validates presence of isbn' do 
		hunter = Hunter.new(isbn: nil)
		hunter.valid?
		hunter.should validate_presence_of_name
	end
	
end