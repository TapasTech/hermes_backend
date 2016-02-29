# frozen_string_literal: true
LocationType = GraphQL::MutableType.define do
  name 'Location'
  description 'Location'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :name, types.String

  mutation do
    field :update, field: LocationsMutation::UpdateLocationField
  end
end
