module Mutations
  class UpdateUser < BaseMutation
    # arguments passed to the `resolved` method
    argument :update, Int, required: true
    argument :username, String, required: true
    argument :password, String, required: true
    argument :enabled, Int, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(update: nil, username: nil, password: nil, enabled: nil)
      User.update(update, userName: username, password: password, enabled: enabled)          
    end
  end
end