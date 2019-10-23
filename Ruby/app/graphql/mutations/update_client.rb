module Mutations
  class UpdateClient < BaseMutation
    # arguments passed to the `resolved` method
    argument :update, Int, required: true
    argument :name, String, required: true
    argument :lname, String, required: true
    argument :address, String, required: true
    argument :identification, String, required: true 
    argument :enabled, Int, required: true

    # return type from the mutation
    type Types::ClientType

    def resolve(update: nil, name: nil, lname: nil, address: nil, identification: nil, enabled: nil)
      Client.update(update, fName: name, lName: lname, address: address, identification: identification, enabled: enabled)          
    end
  end
end