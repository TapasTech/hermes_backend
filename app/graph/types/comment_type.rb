# frozen_string_literal: true
CommentType = GraphQL::MutableType.define do
  name 'Comment'
  description 'Comment'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }, 'Commenter'
  field :replyTo, -> { UserType }, 'Reply to uesr', property: :reply_to
  field :answer, -> { AnswerType }, 'Commented answer'
  field :content, types.String, 'Content'

  RankableTypeMixin.apply(self)

  mutation do
    field :voteUp, field: CommentsMutation::VoteUpField
    field :voteDown, field: CommentsMutation::VoteDownField
  end
end
