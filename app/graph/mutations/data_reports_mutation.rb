# frozen_string_literal: true
module DataReportsMutation
  # Fields
  CreateDataReportField = GraphQL::Field.define do
    type -> { DataReportType }

    argument :title, !types.String
    argument :url, !types.String

    resolve ->(*p) { DataReportsMutation.create(*p) }
  end

  UpdateDataReportField = GraphQL::Field.define do
    type -> { DataReportType }

    argument :title, types.String
    argument :url, types.String

    resolve ->(*p) { DataReportsMutation.update(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, DataReport, :create?

        build_arguments = GraphQLArgumentProcessor.camel_keys_to_underscore(arguments)

        current_user.data_reports.create!(build_arguments)
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
