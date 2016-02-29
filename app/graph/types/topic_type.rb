# frozen_string_literal: true
TopicType = GraphQL::MutableType.define do
  name 'Topic'
  description 'Topic'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :name, types.String
  field :origin, -> { TopicType }
  field :aliases, field: PaginateField.create(Topic, property: :aliases)

  field :questions, field: PaginateField.create(Question, property: :questions)
end
