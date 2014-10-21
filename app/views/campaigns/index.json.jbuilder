json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :title, :name, :description, :store_id, :ibeacon_id, :category_id, :is_active
  json.url campaign_url(campaign, format: :json)
end
