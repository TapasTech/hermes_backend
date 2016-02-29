# frozen_string_literal: true
# Use Pundit in GraphQL
module GraphQLAuthorizer
  # Module Methods
  module ModuleMethods
    def authorize(user, record, query)
      policy = Pundit.policy!(user, record)

      unless policy.public_send(query)
        fail Pundit::NotAuthorizedError, query: query, record: record, policy: policy
      end

      true
    end

    def policy_scope(user, scope)
      Pundit::PolicyFinder.new(scope).scope!.new(user, scope).resolve
    end
  end

  extend ModuleMethods
end
