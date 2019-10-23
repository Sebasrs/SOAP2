module Mutations
  class DeleteClient < BaseMutation
    # arguments passed to the `resolved` method
    argument :delete, Int, required: true

    # return type from the mutation
    type Types::ClientType

    def resolve(delete: nil)
      Client.update(delete, enabled: 0)         
    end
  end
end