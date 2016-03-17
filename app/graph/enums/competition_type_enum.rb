# frozen_string_literal: true
CompetitionTypeEnum = GraphQL::EnumType.define do
  name 'CompetitionTypeEnum'
  description 'Avaliable competition type'
  Competition::TYPES.each do |type|
    value(type, "#{type.humanize} type")
  end
end
