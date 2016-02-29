# frozen_string_literal: true
EducationType = GraphQL::MutableType.define do
  name 'Education'
  description 'Education'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :organization, types.String
  field :direction, types.String

  mutation do
    field :update, field: EducationsMutation::UpdateEducationField
  end
end
