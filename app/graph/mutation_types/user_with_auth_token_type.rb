# frozen_string_literal: true
UserWithAuthTokenType = GraphQL::ObjectType.define do
  name 'UserWithAuthToken'
  description 'User with AuthToken'

  field :user,         UserType
  field :authToken,    types.String, property: :auth_token
end

def UserWithAuthTokenType.wrap(user:, auth_token:)
  OpenStruct.new(user: user, auth_token: auth_token)
end
