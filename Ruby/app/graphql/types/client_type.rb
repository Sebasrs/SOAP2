module Types
  ClientType = GraphQL::ObjectType.define do
    name "Client"
    description "This represents a client"

    field :id, !types.Int
    field :fName, !types.String
    field :lName, !types.String 
    field :address, !types.String
    field :identification, !types.String 
    field :enabled, !types.Int   
  end
end