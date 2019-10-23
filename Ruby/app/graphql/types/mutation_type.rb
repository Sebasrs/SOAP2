module Types
  class MutationType < Types::BaseObject
    field :update_client, mutation: Mutations::UpdateClient
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_client, mutation: Mutations::DeleteClient
    field :delete_user, mutation: Mutations::DeleteUser
    field :create_client, mutation: Mutations::CreateClient
    field :create_user, mutation: Mutations::CreateUser
  end
end
