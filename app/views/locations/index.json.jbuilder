json.array!(@locations) do |location|
  json.extract! location, :id, :name, :zipcode, :latitude, :longitude, :is_active
  json.url location_url(location, format: :json)
end
