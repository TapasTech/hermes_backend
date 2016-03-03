# frozen_string_literal: true
module AuthTokensMutation
  # Fields
  CreateAuthTokenField = GraphQL::Field.define do
    type UserWithAuthTokenType

    argument :email,    !types.String
    argument :password, !types.String

    resolve ->(*p) { AuthTokensMutation.create(*p) }
  end

  RenewAuthTokenField = GraphQL::Field.define do
    type UserWithAuthTokenType

    resolve ->(*p) { AuthTokensMutation.renew(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(_object, arguments, _context)
      user = User.where(email: arguments[:email]).first

      fail CustomGraphQLErrors::AuthenticationError unless user.try(:authenticate, arguments[:password])
      auth_token = AuthToken.new(user.id, user.password_digest).generate
      UserWithAuthTokenType.wrap(user: user, auth_token: auth_token)
    end

    def renew(_object, _arguments, context)
      GraphQLAuthenticator.authenticate(nil, nil, context) do
        auth_token = AuthToken.new(current_user.id, current_user.password_digest).generate

        UserWithAuthTokenType.wrap(user: current_user, auth_token: auth_token)
      end
    end
  end

  extend ResolverMethods
end
