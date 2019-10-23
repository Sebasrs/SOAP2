module Types
  ProvinceType = GraphQL::ObjectType.define do
    name "Province"
    description "This represents a province"

    field :id, !types.Int
    field :name, !types.String
    field :country, !types[Types::CountryType] do
      resolve ->(province, args, ctx) { Country.find_by_sql(
        "SELECT countries.name, countries.id 
        FROM countries JOIN provinces ON provinces.Country_idCountry = countries.id 
        WHERE provinces.idProvince = " + province[:id].to_s + ";") }
    end
  end
end