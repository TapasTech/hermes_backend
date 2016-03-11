# frozen_string_literal: true
EducationType = GraphQL::MutableType.define do
  name 'Education'
  description 'Education'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }
  field :organization, types.String, 'School, academic institution or scholar organization'
  field :direction, types.String, 'Direction'

  mutation do
    field :update, field: EducationsMutation::UpdateEducationField
  end
end
