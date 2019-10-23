json.extract! user, :id, :userName, :password, :Client_idClient, :Restaurant_idRestaurant, :enabled, :created_at, :updated_at
json.url user_url(user, format: :json)
