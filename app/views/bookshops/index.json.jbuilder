json.array!(@bookshops) do |bookshop|
  json.extract! bookshop, :id, :shopname
  json.url bookshop_url(bookshop, format: :json)
end
