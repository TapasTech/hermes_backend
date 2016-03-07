# frozen_string_literal: true
CommentType = GraphQL::MutableType.define do
  name 'Comment'
  description 'Comment'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }, 'Commenter'
  field :replyTo, -> { UserType }, 'Reply to uesr', property: :reply_to
  field :answer, -> { AnswerType }, 'Commented answer'
  field :content, types.String, 'Content'

  field :upVotesCount, types.Int, property: :up_votes_count
  field :downVotesCount, types.Int, property: :down_votes_count
  field :totalVotesCount, types.Int, property: :total_votes_count

  mutation do
    field :voteUp, field: CommentsMutation::VoteUpField
    field :voteDown, field: CommentsMutation::VoteDownField
  end
end
