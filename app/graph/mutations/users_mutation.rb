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

  FollowField = GraphQL::Field.define do
    type -> { UserType }

    resolve ->(*p) { UsersMutation.follow(*p) }
  end

  UnfollowField = GraphQL::Field.define do
    type -> { UserType }

    resolve ->(*p) { UsersMutation.unfollow(*p) }
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
        fail CustomGraphQLErrors::WrongPasswordError unless current_user.authenticate(old_password)

        object.update!(update_arguments)
        object
      end
    end

    # Following
    def follow(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :follow?

        current_user.follow(object)
        object
      end
    end

    def unfollow(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :unfollow?

        current_user.unfollow(object)
        object
      end
    end
  end

  extend ResolverMethods
end
