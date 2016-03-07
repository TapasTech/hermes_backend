# frozen_string_literal: true
EmploymentType = GraphQL::MutableType.define do
  name 'Employment'
  description 'Employment'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }
  field :employment, types.String
  field :position, types.String

  mutation do
    field :update, field: EmploymentsMutation::UpdateEmploymentField
  end
end
