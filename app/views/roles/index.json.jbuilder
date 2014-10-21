json.array!(@roles) do |role|
  json.extract! role, :id, :name, :description, :is_active#, :access_module_id
  json.url role_url(role, format: :json)
end
