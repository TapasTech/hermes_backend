# frozen_string_literal: true
module SolutionsMutation
  # Fields
  CreateSolutionField = GraphQL::Field.define do
    type -> { SolutionType }

    argument :description, !types.String

    resolve ->(*p) { SolutionsMutation.create(*p) }
  end

  UpdateSolutionField = GraphQL::Field.define do
    type -> { SolutionType }

    argument :description, !types.String

    resolve ->(*p) { SolutionsMutation.update(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        build_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments
        build_arguments[:competition] = object
        # only build without save then to authorize
        solution = current_user.participate(build_arguments)
        GraphQLAuthorizer.authorize(current_user, solution, :create?)

        solution.tap(&:save!)
      end
    end

    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize(current_user, object, :update?)
        build_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        object.update!(build_arguments)
        object
      end
    end
  end

  extend ResolverMethods
end
