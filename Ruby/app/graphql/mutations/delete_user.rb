module Mutations
  class DeleteUser < BaseMutation
    # arguments passed to the `resolved` method
    argument :delete, Int, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(delete: nil)
      User.update(delete, enabled: 0)         
    end
  end
end