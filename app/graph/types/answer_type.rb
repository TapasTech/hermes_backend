# frozen_string_literal: true
AnswerType = GraphQL::MutableType.define do
  name 'Answer'
  description 'Answer'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :question, -> { QuestionType }
  field :content, types.String

  field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
  field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)
  field :comments, field: PaginateField.create(Comment, property: :comments)

  field :upsCount, types.Int
  field :downsCount, types.Int

  mutation do
    field :update, field: AnswersMutation::UpdateAnswerField

    field :addDataSet, field: AnswersMutation::AddDataSetField
    field :removeDataSet, field: AnswersMutation::RemoveDataSetField

    field :addDataReport, field: AnswersMutation::AddDataReportField
    field :removeDataReport, field: AnswersMutation::RemoveDataReportField
    
    field :voteUp, field: AnswersMutation::VoteUpField
    field :voteDown, field: AnswersMutation::VoteDownField
  end
end
