module Mutations
  class CreateUser < BaseMutation
    # arguments passed to the `resolved` method
    argument :clientid, Int, required: true
    argument :restaurantid, Int, required: true
    argument :username, String, required: true
    argument :password, String, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(clientid: nil, username: nil, password: nil, restaurantid: nil)
      User.create(userName: username, password: password, Client_idClient: clientid, Restaurant_idRestaurant: restaurantid, enabled: 1)          
    end
  end
end