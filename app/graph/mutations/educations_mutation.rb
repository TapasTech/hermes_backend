# frozen_string_literal: true
module EducationsMutation
  # Fields
  UpdateEducationField = GraphQL::Field.define do
    type -> { EducationType }

    argument :education, types.String
    argument :position, types.String

    resolve ->(*p) { EducationsMutation.update(*p) }
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
          object.destroy!.user.educations.build
        end
      end
    end
  end

  extend ResolverMethods
end
