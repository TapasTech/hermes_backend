# frozen_string_literal: true
TopicType = GraphQL::MutableType.define do
  name 'Topic'
  description 'Topic'

  BaseModelTypeMixin.apply(self)

  field :name, types.String, 'Name'
  field :origin, -> { TopicType }, 'The origin of this alias, if this topic is an alias of other topics'
  field :aliases, field: PaginateField.create(Topic, property: :aliases)

  field :questions, field: PaginateField.create(Question, property: :questions,
                                                          transform: ->(a) { a.order('hot DESC NULLS LAST') })
end
