# frozen_string_literal: true
OngoingCompetitionsField = GraphQL::Field.define do
  type -> { types[CompetitionType] }

  resolve ->(*p) { OngoingCompetitionsField.list(*p) }
end

def OngoingCompetitionsField.list(object, arguments, context)
  GraphQLAuthenticator.execute(object, arguments, context) do
    # This query is EVIL, should be replaced by an search engine
    records = Competition.active_when(Time.zone.now).order(competition_type: :asc, expire_at: :asc)
    GraphQLAuthorizer.policy_scope current_user, records
  end
end
