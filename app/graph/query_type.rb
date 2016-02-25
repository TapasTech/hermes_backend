# frozen_string_literal: true
QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'Query Root'

  # Add your queries here
  # field :user, field: FetchField.create(User)

  # Put your query fields under: queries/
  # Put your data types under: types/
end
