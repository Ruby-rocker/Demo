json.array!(@access_modules) do |access_module|
  json.extract! access_module, :id, :name, :is_active
  json.url access_module_url(access_module, format: :json)
end
