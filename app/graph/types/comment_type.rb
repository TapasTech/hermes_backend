# frozen_string_literal: true
CommentType = GraphQL::MutableType.define do
  name 'Comment'
  description 'Comment'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :replyTo, -> { UserType }, property: :reply_to
  field :answer, -> { AnswerType }
  field :content, types.String
end
