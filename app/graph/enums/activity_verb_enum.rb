# frozen_string_literal: true
ActivityVerbEnum = GraphQL::EnumType.define do
  name 'ActivityVerbEnum'
  description 'Verbs may be done by users.'
  Activity::VERBS.each do |verb|
    value(verb, "#{verb.humanize} activity")
  end
end
