# frozen_string_literal: true
CommentType = GraphQL::MutableType.define do
  name 'Comment'
  description 'Comment'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }, 'Commenter'
  field :replyTo, -> { UserType }, 'Reply to uesr', property: :reply_to
  field :answer, -> { AnswerType }, 'Commented answer'
  field :content, types.String, 'Content'

  field :upVotesCount, types.Int, 'Up vote count', property: :up_votes_count
  field :downVotesCount, types.Int, 'Down vote count', property: :down_votes_count
  field :totalVotesCount, types.Int, 'Total vote count', property: :total_votes_count

  mutation do
    field :voteUp, field: CommentsMutation::VoteUpField
    field :voteDown, field: CommentsMutation::VoteDownField
  end
end
