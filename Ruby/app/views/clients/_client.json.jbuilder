json.extract! client, :id, :fName, :lName, :address, :identification, :enabled, :created_at, :updated_at
json.url client_url(client, format: :json)
