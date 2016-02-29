# frozen_string_literal: true
QuestionType = GraphQL::MutableType.define do
  name 'Question'
  description 'Question'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :title, types.String
  field :content, types.String
  field :topics, -> { types[TopicType] }

  field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
  field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)
  field :answers, field: PaginateField.create(Answer, property: :answers)
end
