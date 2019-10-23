module Types
  RestaurantType = GraphQL::ObjectType.define do
    name "Restaurant"
    description "This represents a restaurant"

    field :id, !types.Int
    field :name, !types.String
    field :address, !types.String
    field :contactNumber, !types.String
    field :disponibilityDays, !types.String
    field :disponibilityHours, !types.String
    field :province, !types[Types::ProvinceType] do
      resolve ->(restaurant, args, ctx) { 
        Province.find_by_sql(
          "SELECT provinces.name, provinces.idProvince 
          FROM provinces JOIN restaurants ON restaurants.Province_idProvince = provinces.idProvince 
          WHERE restaurants.idRestaurant = " + restaurant[:id].to_s + ";") }
    end
  end
end