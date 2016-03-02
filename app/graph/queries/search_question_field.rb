# frozen_string_literal: true
SearchQuestionField = GraphQL::Field.define do
  type PaginateField.paginated_type(Question)

  argument :query, !types.String
  argument :page,  types.Int
  argument :count, types.Int

  resolve ->(*p) { SearchQuestionField.query(*p) }
end

def SearchQuestionField.query(object, arguments, context)
  GraphQLAuthenticator.execute(object, arguments, context) do
    # This query is EVIL, should be replaced by an search engine
    records = Question.where('title LIKE ?', "%#{arguments[:query]}%")

    GraphQLAuthorizer.policy_scope current_user, records.page(arguments[:page]).per(arguments[:count])
  end
end
