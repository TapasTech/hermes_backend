# frozen_string_literal: true
# Use Pundit in GraphQL
module GraphQLArgumentProcessor
  # Module Methods
  module ModuleMethods
    # check if arguments values are all nil
    def blank?(arguments)
      arguments.values.map(&:blank?).reduce(:&)
    end

    def camel_keys_to_underscore(arguments)
      arguments.to_h
               .stringify_keys
               .transform_keys(&:underscore)
               .symbolize_keys
    end
  end

  extend ModuleMethods
end
