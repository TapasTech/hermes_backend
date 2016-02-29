# frozen_string_literal: true
module UsersMutation
  # Fields
  CreateUserField = GraphQL::Field.define do
    type -> { UserType }

    argument :displayName, !types.String
    argument :password,    !types.String
    argument :email,       types.String

    resolve ->(*p) { UsersMutation.create(*p) }
  end

  UpdateUserField = GraphQL::Field.define do
    type -> { UserType }

    argument :oldPassword, !types.String
    argument :displayName, types.String
    argument :password,    !types.String
    argument :email,       types.String

    resolve ->(*p) { UsersMutation.update(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(_object, arguments, _context)
      GraphQLAuthorizer.authorize nil, User, :create?

      build_arguments =
        GraphQLArgumentProcessor.camel_keys_to_underscore arguments

      User.create!(build_arguments)
    end

    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :update?

        update_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        old_password = update_arguments.delete(:old_password)
        fail TapasGraphQLErrors::WrongPasswordError unless current_user.authenticate(old_password)

        object.update!(update_arguments)
        object
      end
    end
  end

  extend ResolverMethods
end
