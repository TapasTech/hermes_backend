# frozen_string_literal: true
EducationType = GraphQL::MutableType.define do
  name 'Education'
  description 'Education'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Detele datetime', property: :deleted_at

  field :user, -> { UserType }
  field :organization, types.String
  field :direction, types.String

  mutation do
    field :update, field: EducationsMutation::UpdateEducationField
  end
end
