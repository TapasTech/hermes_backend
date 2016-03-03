# frozen_string_literal: true
module QuestionsMutation
  # Fields
  CreateQuestionField = GraphQL::Field.define do
    type -> { QuestionType }

    argument :title, !types.String
    argument :content, !types.String

    resolve ->(*p) { QuestionsMutation.create(*p) }
  end

  UpdateQuestionField = GraphQL::Field.define do
    type -> { QuestionType }

    argument :title, !types.String
    argument :content, types.String

    resolve ->(*p) { QuestionsMutation.update(*p) }
  end

  AddTopicField = GraphQL::Field.define do
    type -> { TopicType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.add_topic(*p) }
  end

  RemoveTopicField = GraphQL::Field.define do
    type -> { TopicType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.remove_topic(*p) }
  end

  AddDataSetField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.add_data_set(*p) }
  end

  RemoveDataSetField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.remove_data_set(*p) }
  end

  AddDataReportField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.add_data_report(*p) }
  end

  RemoveDataReportField = GraphQL::Field.define do
    type -> { DataSetType }

    argument :id, !types.ID

    resolve ->(*p) { QuestionsMutation.remove_data_report(*p) }
  end

  VoteUpField = GraphQL::Field.define do
    type -> { QuestionType }

    resolve ->(*p) { QuestionsMutation.vote_up(*p) }
  end

  VoteDownField = GraphQL::Field.define do
    type -> { QuestionType }

    resolve ->(*p) { QuestionsMutation.vote_down(*p) }
  end

  FollowField = GraphQL::Field.define do
    type -> { QuestionType }

    resolve ->(*p) { QuestionsMutation.follow(*p) }
  end

  UnfollowField = GraphQL::Field.define do
    type -> { QuestionType }

    resolve ->(*p) { QuestionsMutation.unfollow(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, _context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, Question, :create?
        build_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        current_user.ask(build_arguments)
      end
    end

    def update(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :update?

        update_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        object.update!(update_arguments)
        object
      end
    end

    # Topic
    def add_topic(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :add_topic?

        topic = Topic.find(arguments[:id])
        object.topics << topic
        object
      end
    end

    def remove_topic(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :remove_topic?

        topic = object.topics.find(arguments[:id])
        object.topics.destroy(topic)
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

        current_user.vote_up_question(object)
        object
      end
    end

    def vote_down(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :vote_down?

        current_user.vote_down_question(object)
        object
      end
    end

    # Following
    def follow(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :follow?

        current_user.follow_question(object)
        object
      end
    end

    def unfollow(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :unfollow?

        current_user.unfollow_question(object)
        object
      end
    end
  end

  extend ResolverMethods
end
