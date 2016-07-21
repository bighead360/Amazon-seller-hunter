json.array!(@isbns) do |isbn|
  json.extract! isbn, :id, :isbn
  json.url isbn_url(isbn, format: :json)
end
