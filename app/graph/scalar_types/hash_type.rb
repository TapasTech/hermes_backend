# frozen_string_literal: true
HashType = GraphQL::ScalarType.define do
  name 'Object'
  description 'Key-Value Attributes'

  coerce_result -> (value) { value.as_json }
end
