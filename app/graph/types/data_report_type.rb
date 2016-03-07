# frozen_string_literal: true
DataReportType = GraphQL::MutableType.define do
  name 'DataReport'
  description 'Data Report'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }, 'Uploader'
  field :title, types.String, 'Title'
  field :url, types.String, 'Link'

  field :questions, field: PaginateField.create(Question, property: :questions)
  field :answers, field: PaginateField.create(Answer, property: :answers)

  mutation do
    field :update, field: DataReportsMutation::UpdateDataReportField
  end
end
