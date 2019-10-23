module Types
  class QueryType < Types::BaseObject
    
    field :all_countries, [Types::CountryType], null: false          
    def all_countries      
      Country.all      
    end


    field :one_country, Types::CountryType, null: false do
      argument :id, ID, required: true
    end        
    def one_country(id:)      
      Country.find(id)      
    end

    field :all_provinces, [Types::ProvinceType], null: false
    def all_provinces
      Province.all
    end

    field :one_province, Types::ProvinceType, null: false do
      argument :id, ID, required: true
    end        
    def one_province(id:)      
      Province.find(id)      
    end

    field :all_restaurants, [Types::RestaurantType], null: false
    def all_restaurants
      Restaurant.all
    end 
    
    field :one_restaurant, Types::RestaurantType, null: false do
      argument :id, ID, required: true
    end        
    def one_restaurant(id:)      
      Restaurant.find(id)      
    end

    field :all_users, [Types::UserType], null: false 
    def all_users
      User.all
    end   
    field :one_user, Types::UserType, null: false do
      argument :id, ID, required: true
    end        
    def one_user(id:)      
      User.find(id)      
    end 

    field :all_clients, [Types::ClientType], null: false
    def all_clients
      Client.all
    end
    field :one_client, Types::ClientType, null: false do
      argument :id, ID, required: true
    end        
    def one_client(id:)      
      Client.find(id)      
    end 
  end
end
