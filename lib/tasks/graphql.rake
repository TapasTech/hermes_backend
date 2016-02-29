# frozen_string_literal: true
namespace :graphql do
  task export: [:environment] do
    File.open('doc/schema.json', 'w') do |f|
      f.puts JSON.pretty_generate ApplicationSchema.execute GraphQL::Introspection::INTROSPECTION_QUERY
    end
  end
end
