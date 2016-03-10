# frozen_string_literal: true
AnswerType = GraphQL::MutableType.define do
  name 'Answer'
  description 'Answer'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }, 'Answerer'
  field :question, -> { QuestionType }, 'Question'
  field :content, types.String, 'Content'

  field :dataSets, field: PaginateField.create(DataSet, property: :data_sets)
  field :dataReports, field: PaginateField.create(DataReport, property: :data_reports)
  field :comments, field: PaginateField.create(Comment, property: :comments,
                                                        transform: ->(a) { a.order(created_at: :desc) })
  field :commentsCount, types.Int, 'Comment count', property: :comments_count

  field :upVotesCount, types.Int, 'Up vote count', property: :up_votes_count
  field :downVotesCount, types.Int, 'Down vote count', property: :down_votes_count
  field :totalVotesCount, types.Int, 'Total vote count', property: :total_votes_count

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
