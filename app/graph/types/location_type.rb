# frozen_string_literal: true
LocationType = GraphQL::MutableType.define do
  name 'Location'
  description 'Location'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }
  field :name, types.String

  mutation do
    field :update, field: LocationsMutation::UpdateLocationField
  end
end
