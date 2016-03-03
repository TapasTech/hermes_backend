# frozen_string_literal: true
module LocationsMutation
  # Fields
  UpdateLocationField = GraphQL::Field.define do
    type -> { LocationType }

    argument :name, types.String

    resolve ->(*p) { LocationsMutation.update(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :update?

        update_arguments = GraphQLArgumentProcessor.camel_keys_to_underscore(arguments)

        if !GraphQLArgumentProcessor.blank?(update_arguments)
          object.update!(update_arguments)
          object
        else
          object.destroy!.user.locations.build
        end
      end
    end
  end

  extend ResolverMethods
end
