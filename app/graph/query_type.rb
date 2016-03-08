# frozen_string_literal: true
QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'Query Root'

  field :user, field: FetchField.create(User)
  field :me, field: MeField

  field :topic, field: FetchField.create(Topic)
  field :topics, field: PaginateField.create(Topic)

  field :question, field: FetchField.create(Question, transform: ->(question) { question.tap(&:read) })
  field :answer, field: FetchField.create(Answer)
  field :comment, field: FetchField.create(Comment)

  field :dataSets, field: PaginateField.create(DataSet)
  field :dataReports, field: PaginateField.create(DataReport)

  field :hotAnswers, field: PaginateField.create(Answer, transform: ->(a) { a.where('hot IS NOT NULL').order(hot: :desc) })
  field :bestAnalysts, field: GlobalDataAnalystRankingField

  field :searchQuestions, field: SearchQuestionField
end
