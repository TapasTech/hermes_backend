# frozen_string_literal: true
module DataSetsMutation
  # Fields
  CreateDataSetField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :title, !types.String
    argument :url, !types.String

    resolve ->(*p) { DataSetsMutation.create(*p) }
  end
  
  UpdateDataSetField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :title, types.String
    argument :url, types.String

    resolve ->(*p) { DataSetsMutation.update(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, DataSet, :create?

        build_arguments = GraphQLArgumentProcessor.camel_keys_to_underscore(arguments)

        current_user.data_sets.create!(build_arguments)
      end
    end

    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :update?

        update_arguments = GraphQLArgumentProcessor.camel_keys_to_underscore(arguments)

        object.update!(update_arguments)
        object
      end
    end
  end

  extend ResolverMethods
end
