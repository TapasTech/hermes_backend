# frozen_string_literal: true
QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'Query Root'

  field :user, field: FetchField.create(User)
  field :me, field: MeField

  field :topic, field: FetchField.create(Topic)
  field :topics, field: PaginateField.create(Topic)

  field :question, field: FetchField.create(Question)
  field :questions, field: PaginateField.create(Question, transform: ->(a) { a.order(created_at: :desc) })
  field :answer, field: FetchField.create(Answer)
  field :comment, field: FetchField.create(Comment)
  field :competition, field: FetchField.create(Competition)
  field :ongoingCompetitions, field: OngoingCompetitionsField
  field :competitions,
        field: PaginateField.create(
          Competition,
          transform: ->(a) { a.order(end_at: :desc) })

  field :dataSets, field: PaginateField.create(DataSet, transform: ->(a) { a.order(created_at: :desc) })
  field :dataReports, field: PaginateField.create(DataReport, transform: ->(a) { a.order(created_at: :desc) })

  field :hotAnswers, field: PaginateField.create(Answer, transform: ->(a) { a.order('hot DESC NULLS LAST') })
  field :bestAnalysts, field: GlobalDataAnalystRankingField

  field :searchQuestions, field: SearchQuestionField
end
