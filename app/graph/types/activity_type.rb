# frozen_string_literal: true
ActivityType = GraphQL::MutableType.define do
  name 'Activity'
  description 'Activity'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at

  field :user, -> { ActivityVerbEnum }, 'User'
  field :verb, types.String, 'Activity Name'
  field :payload, HashType, 'Activity Payload'

  field :answer, -> { AnswerType }, 'Related Answer'
  field :question, -> { QuestionType }, 'Related Question'
end
