# frozen_string_literal: true
MeField = GraphQL::Field.define do
  type -> { UserType }

  resolve lambda { |object, arguments, context|
    GraphQLAuthenticator.authenticate(object, arguments, context) do
      current_user
    end
  }
end
