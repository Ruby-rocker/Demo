json.array!(@template_masters) do |template_master|
  json.extract! template_master, :id, :name, :description
  json.url template_master_url(template_master, format: :json)
end
