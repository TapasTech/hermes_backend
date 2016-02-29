# frozen_string_literal: true
BusinessType = GraphQL::MutableType.define do
  name 'Business'
  description 'Business'

  field :id, !types.ID
  field :createdAt, -> { DateType }, property: :created_at
  field :updatedAt, -> { DateType }, property: :updated_at
  field :deletedAt, -> { DateType }, property: :deleted_at

  field :user, -> { UserType }
  field :parentBusiness, -> { BusinessType }, property: :parent_business
  field :childBusinesses, -> { types[BusinessType] }, property: :child_businesses
end
