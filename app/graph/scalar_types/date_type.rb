# frozen_string_literal: true
DateType = GraphQL::ScalarType.define do
  name 'Date'
  description 'ISO-8601 Format (YYYY-MM-DD\'T\'hh:mm:ss.sssZZZZZ)'

  coerce_input -> (value) { Time.zone.parse value }
  coerce_result -> (value) { value.as_json }
end
