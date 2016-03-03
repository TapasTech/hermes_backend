# frozen_string_literal: true
DataReportType = GraphQL::MutableType.define do
  name 'DataReport'
  description 'Data Report'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :title, types.String
  field :url, types.String

  field :questions, field: PaginateField.create(Question, property: :questions)
  field :answers, field: PaginateField.create(Answer, property: :answers)

  mutation do
    field :update, field: DataReportsMutation::UpdateDataReportField
  end
end
