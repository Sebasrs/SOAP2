module Types
  CountryType = GraphQL::ObjectType.define do
    name "Country"
    description "This represents a country"

    field :id, !types.Int
    field :name, !types.String
  end
end