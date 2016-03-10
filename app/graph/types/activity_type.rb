# frozen_string_literal: true
ActivityType = GraphQL::MutableType.define do
  name 'Activity'
  description 'Activity'

  BaseModelTypeMixin.apply(self, paranoia: false)

  field :user, -> { UserType }, 'User'
  field :verb, -> { ActivityVerbEnum }, 'Activity Name'
  field :payload, HashType, 'Activity Payload'

  field :answer, -> { AnswerType }, 'Related Answer'
  field :question, -> { QuestionType }, 'Related Question'
end
