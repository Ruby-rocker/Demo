json.array!(@stores) do |store|
  json.extract! store, :id, :name, :location_id, :is_active
  json.url store_url(store, format: :json)
end
