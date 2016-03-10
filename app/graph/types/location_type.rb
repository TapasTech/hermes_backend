# frozen_string_literal: true
LocationType = GraphQL::MutableType.define do
  name 'Location'
  description 'Location'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }
  field :name, types.String, 'Name'

  mutation do
    field :update, field: LocationsMutation::UpdateLocationField
  end
end
