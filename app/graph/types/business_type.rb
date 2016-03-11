# frozen_string_literal: true
BusinessType = GraphQL::MutableType.define do
  name 'Business'
  description 'Business'

  BaseModelTypeMixin.apply(self)

  field :parentBusiness, -> { BusinessType }, 'Parent Business', property: :parent_business
  field :childBusinesses, -> { types[BusinessType] }, 'Child Businesses', property: :child_businesses
end
