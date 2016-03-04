# frozen_string_literal: true
module CommentsMutation
  # Fields
  CreateCommentField = GraphQL::Field.define do
    type -> { CommentType }

    argument :content, !types.String
    argument :reply_to_id, types.ID

    resolve ->(*p) { CommentsMutation.create(*p) }
  end

  VoteUpField = GraphQL::Field.define do
    type -> { CommentType }

    resolve ->(*p) { CommentsMutation.vote_up(*p) }
  end

  VoteDownField = GraphQL::Field.define do
    type -> { CommentType }

    resolve ->(*p) { CommentsMutation.vote_down(*p) }
  end

  # Methods that resolves
  module ResolverMethods
    def create(object, arguments, _context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, Comment, :create?
        build_arguments =
          GraphQLArgumentProcessor.camel_keys_to_underscore arguments

        build_arguments.merge(user: current_user, reply_to: CommentsMutation.extract_reply_to!(build_arguments))
        object.comments.create!(build_arguments)
      end
    end

    def extract_reply_to!(arguments)
      reply_to_id = arguments.delete(:reply_to_id)
      User.find(reply_to_id) if reply_to_id.present
    end

    # Voting
    def vote_up(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :vote_up?

        current_user.vote_up_comment(object)
        object
      end
    end

    def vote_down(object, arguments, context)
      GraphQLAuthenticator.authenticate(object, arguments, context) do
        GraphQLAuthorizer.authorize current_user, object, :vote_down?

        current_user.vote_down_comment(object)
        object
      end
    end
  end

  extend ResolverMethods
end
