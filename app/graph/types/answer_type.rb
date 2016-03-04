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
  field :commentsCount, types.Int, property: :comments_count

  field :upVotesCount, types.Int, property: :up_votes_count
  field :downVotesCount, types.Int, property: :down_votes_count
  field :totalVotesCount, types.Int, property: :total_votes_count

  mutation do
    field :update, field: AnswersMutation::UpdateAnswerField

    field :addDataSet, field: AnswersMutation::AddDataSetField
    field :removeDataSet, field: AnswersMutation::RemoveDataSetField

    field :addDataReport, field: AnswersMutation::AddDataReportField
    field :removeDataReport, field: AnswersMutation::RemoveDataReportField

    field :voteUp, field: AnswersMutation::VoteUpField
    field :voteDown, field: AnswersMutation::VoteDownField

    field :createComment, field: CommentsMutation::CreateCommentField
  end
end
