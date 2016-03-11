# frozen_string_literal: true
EmploymentType = GraphQL::MutableType.define do
  name 'Employment'
  description 'Employment'

  BaseModelTypeMixin.apply(self)

  field :user, -> { UserType }
  field :employment, types.String, 'Enterprise'
  field :position, types.String, 'Position'

  mutation do
    field :update, field: EmploymentsMutation::UpdateEmploymentField
  end
end
