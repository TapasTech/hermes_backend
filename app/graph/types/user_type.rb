# frozen_string_literal: true
UserType = GraphQL::MutableType.define do
  name 'User'
  description 'User'

  field :email, types.String
  field :display_name, types.String
  field :gender, types.String

  field :business, -> { BusinessType }
  field :locations, -> { [LocationType] }
  field :employments, -> { [EmploymentType] }
  field :educations, -> { [EducationType] }
end
