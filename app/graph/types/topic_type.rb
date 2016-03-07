# frozen_string_literal: true
TopicType = GraphQL::MutableType.define do
  name 'Topic'
  description 'Topic'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :name, types.String, 'Name'
  field :origin, -> { TopicType }, 'The origin of this alias, if this topic is an alias of other topics'
  field :aliases, field: PaginateField.create(Topic, property: :aliases)

  field :questions, field: PaginateField.create(Question, property: :questions,
                                                          transform: ->(a) { a.order(hot: :desc) })
end
