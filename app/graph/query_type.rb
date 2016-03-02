# frozen_string_literal: true
QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'Query Root'

  field :user, field: FetchField.create(User)
  field :me, field: MeField

  field :topic, field: FetchField.create(Topic)
  field :topics, field: PaginateField.create(Topic)

  field :question, field: FetchField.create(Question)
  field :answer, field: FetchField.create(Answer)

  field :hotAnswers, field: PaginateField.create(Topic, transform: ->(a) { a.includes(:question).order(hot: :desc) })

  field :searchQuestions, field: SearchQuestionField
end
