# frozen_string_literal: true
EmploymentType = GraphQL::MutableType.define do
  name 'Employment'
  description 'Employment'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :employment, types.String
  field :position, types.String

  mutation do
    field :update, field: EmploymentsMutation::UpdateEmploymentField
  end
end
