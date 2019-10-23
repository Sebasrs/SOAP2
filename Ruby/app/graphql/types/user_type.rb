module Types
  UserType = GraphQL::ObjectType.define do
    name "User"
    description "This represents an user"

    field :id, !types.Int
    field :userName, !types.String
    field :password, !types.String  
    field :enabled, !types.Int
    field :client, !types[Types::ClientType] do
      resolve ->(user, args, ctx) { 
        Client.find_by_sql(
          "SELECT clients.fName, clients.lName, clients.address, clients.identification 
          FROM clients JOIN users ON users.Client_idClient = clients.idClient 
          WHERE users.idUser = " + user[:id].to_s + ";") 
      }
    end 
    field :restaurant, !types[Types::RestaurantType] do
      resolve ->(user, args, ctx) { 
        Client.find_by_sql(
          "SELECT restaurants.idRestaurant, restaurants.name, restaurants.address, restaurants.contactNumber, restaurants.disponibilityDays, restaurants.disponibilityHours 
          FROM restaurants JOIN users ON users.Restaurant_idRestaurant = restaurants.idRestaurant 
          WHERE users.idUser = " + user[:id].to_s + ";") 
      }
    end  
  end
end