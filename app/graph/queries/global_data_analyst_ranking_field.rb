# frozen_string_literal: true
# GDAR
# Rank all answerers by confidence
GlobalDataAnalystRankingField = GraphQL::Field.define do
  type PaginateField.paginated_type(User)

  argument :page,  types.Int
  argument :count, types.Int

  resolve ->(*p) { GlobalDataAnalystRankingField.query(*p) }
end

def GlobalDataAnalystRankingField.query(object, arguments, context)
  GraphQLAuthenticator.execute(object, arguments, context) do
    records = User.order(desc: :confidence)

    GraphQLAuthorizer.policy_scope current_user, records.page(arguments[:page]).per(arguments[:count])
  end
end
