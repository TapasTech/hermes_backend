# frozen_string_literal: true
module AnswersMutation
  # Fields
  CreateAnswerField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :content, !types.String

    resolve ->(*p) { AnswersMutation.create(*p) }
  end

  UpdateAnswerField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :content, types.String

    resolve ->(*p) { AnswersMutation.update(*p) }
  end

  AddDataSetField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :id, !types.ID

    resolve ->(*p) { AnswersMutation.add_data_set(*p) }
  end

  RemoveDataSetField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :id, !types.ID

    resolve ->(*p) { AnswersMutation.remove_data_set(*p) }
  end

  AddDataReportField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :id, !types.ID

    resolve ->(*p) { AnswersMutation.add_data_report(*p) }
  end

  RemoveDataReportField = GraphQL::Field.define do
    type -> { AnswerType }

    argument :id, !types.ID

    resolve ->(*p) { AnswersMutation.remove_data_report(*p) }
  end

  VoteUpField = GraphQL::Field.define do
    type -> { AnswerType }

    resolve ->(*p) { AnswersMutation.vote_up(*p) }
  end

  VoteDownField = GraphQL::Field.define do
    type -> { AnswerType }

    resolve ->(*p) { AnswersMutation.vote_down(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(_object, arguments, _context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, Answer, :create?
        build_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        build_arguments.merge(question: object)
        user.answer(build_arguments)
      end
    end

    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :update?

        update_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments
        update_arguments.merge(edited_at: Time.zone.now) if update_arguments[:content]&.!= object.content

        object.update!(update_arguments)
        object
      end
    end

    # DataSet
    def add_data_set(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :add_data_set?

        data_set = DataSet.find(arguments[:id])
        object.data_sets << data_set
        object
      end
    end

    def remove_data_set(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :remove_data_set?

        data_set = object.data_sets.find(arguments[:id])
        object.data_sets.destroy(data_set)
        object
      end
    end

    # DataReport
    def add_data_report(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :add_data_report?

        data_report = DataReport.find(arguments[:id])
        object.data_reports << data_report
        object
      end
    end

    def remove_data_report(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :remove_data_report?

        data_report = object.data_reports.find(arguments[:id])
        object.data_reports.destroy(data_report)
        object
      end
    end

    # Voting
    def vote_up(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :vote_up?

        current_user.vote_up_answer(object)
        object
      end
    end

    def vote_down(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :vote_down?

        current_user.vote_down_answer(current_user)
        object
      end
    end
  end

  extend ResolverMethods
end
