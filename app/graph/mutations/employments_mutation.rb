# frozen_string_literal: true
module EmploymentsMutation
  # Fields
  UpdateEmploymentField = GraphQL::Field.define do
    type -> { EmploymentType }

    argument :employment, types.String
    argument :position, types.String

    resolve ->(*p) { EmploymentsMutation.update(*p) }
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
          object.destroy!.user.employments.build
        end
      end
    end
  end

  extend ResolverMethods
end
