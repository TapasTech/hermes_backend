# frozen_string_literal: true
ActivityType = GraphQL::MutableType.define do
  name 'Activity'
  description 'Activity'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at

  field :user, -> { UserType }
  field :verb, types.String
  field :payload, HashType
end
