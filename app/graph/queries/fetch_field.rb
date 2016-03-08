# frozen_string_literal: true
# Fetch data by ID
class FetchField
  def self.create(model, transform: nil)
    GraphQL::Field.define do
      type -> { "::#{model.name}Type".constantize }
      description model.name.humanize

      argument :id, !types.String

      resolve FetchField.resolver(model, transform: transform)
    end
  end

  def self.resolver(model, transform: nil)
    lambda do |object, arguments, context|
      GraphQLAuthenticator.execute(object, arguments, context) do
        record = model.find(arguments[:id])

        GraphQLAuthorizer.authorize current_user, record, :show?
        return record unless transform.present?
        transform.call(record)
      end
    end
  end
end
