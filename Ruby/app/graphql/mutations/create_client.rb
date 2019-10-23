module Mutations
  class CreateClient < BaseMutation
    # arguments passed to the `resolved` method
    argument :name, String, required: true
    argument :lname, String, required: true
    argument :address, String, required: true
    argument :identification, String, required: true

    # return type from the mutation
    type Types::ClientType

    def resolve(update: nil, name: nil, lname: nil, address: nil, identification: nil)
      Client.create(fName: name, lName: lname, address: address, identification: identification, enabled: 1)          
    end
  end
end