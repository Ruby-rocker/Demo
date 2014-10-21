json.array!(@ibeacons) do |ibeacon|
  json.extract! ibeacon, :id, :name, :description, :store_id, :broadcast_id, :is_active
  json.url ibeacon_url(ibeacon, format: :json)
end
