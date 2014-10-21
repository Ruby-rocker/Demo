json.array!(@contacts) do |contact|
  json.extract! contact, :id, :uuid, :udid, :first_name, :last_name, :email_address, :contact_no, :latitude, :longitude
  json.url contact_url(contact, format: :json)
end
