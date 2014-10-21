json.array!(@beacon_ranges) do |beacon_range|
  json.extract! beacon_range, :id, :name, :is_active
  json.url beacon_range_url(beacon_range, format: :json)
end
