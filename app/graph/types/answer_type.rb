# frozen_string_literal: true
AnswerType = GraphQL::MutableType.define do
  name 'Answer'
  description 'Answer'

  BaseModelTypeMixin.apply(self)
  DatableTypeMixin.apply(self)
  RankableTypeMixin.apply(self)

  field :editedAt, -> { DateType }, 'Edit datetime', property: :edited_at
  field :user, -> { UserType }, 'Answerer'
  field :question, -> { QuestionType }, 'Question'
  field :content, types.String, 'Content'

  field :comments, field: PaginateField.create(Comment, property: :comments,
                                                        transform: ->(a) { a.order(created_at: :desc) })
  field :commentsCount, types.Int, 'Comment count', property: :comments_count

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
