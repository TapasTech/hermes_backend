# frozen_string_literal: true
# Fetch data by ID
class FetchField
  def self.create(model)
    GraphQL::Field.define do
      type -> { "::#{model.name}Type".constantize }

      argument :id, !types.String

      resolve FetchField.resolver(model)
    end
  end

  def self.resolver(model)
    lambda do |object, arguments, context|
      GraphQLAuthenticator.execute(object, arguments, context) do
        record = model.find(arguments[:id])

        GraphQLAuthorizer.authorize current_user, record, :show?
        record
      end
    end
  end
end
