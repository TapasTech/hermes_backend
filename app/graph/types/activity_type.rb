# frozen_string_literal: true
ActivityType = GraphQL::MutableType.define do
  name 'Activity'
  description 'Activity'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at

  field :user, -> { UserType }, 'User'
  field :verb, -> { ActivityVerbEnum }, 'Activity Name' do
    resolve -> (object, _arguments, _context) { object.verb.to_s }
  end
  field :payload, HashType, 'Activity Payload'

  field :answer, -> { AnswerType }, 'Related Answer'
  field :question, -> { QuestionType }, 'Related Question'
end
