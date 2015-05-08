json.array!(@contacts) do |contact|
  json.extract! contact, :id, :first_name, :last_name, :street, :city, :state, :zip_code, :phone_number
  json.url contact_url(contact, format: :json)
end
