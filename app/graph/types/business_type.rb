# frozen_string_literal: true
BusinessType = GraphQL::MutableType.define do
  name 'Business'
  description 'Business'

  field :id, !types.ID, 'ID'
  field :createdAt, -> { DateType }, 'Create datetime', property: :created_at
  field :updatedAt, -> { DateType }, 'Update datetime', property: :updated_at
  field :deletedAt, -> { DateType }, 'Delete datetime', property: :deleted_at

  field :parentBusiness, -> { BusinessType }, 'Parent Business', property: :parent_business
  field :childBusinesses, -> { types[BusinessType] }, 'Child Businesses', property: :child_businesses
end
