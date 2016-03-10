# frozen_string_literal: true
GenderEnum = GraphQL::EnumType.define do
  name 'GenderEnum'
  description 'Genders users may be.'
  User::GENDERS.each do |gender|
    value(gender, gender.humanize)
  end
end
