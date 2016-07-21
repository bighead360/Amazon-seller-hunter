json.array!(@hunters) do |hunter|
  json.extract! hunter, :id, :isbn, :condition, :status
  json.url hunter_url(hunter, format: :json)
end
