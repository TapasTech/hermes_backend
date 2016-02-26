# frozen_string_literal: true
ApplicationSchema = GraphQL::Schema.new(
  query: QueryType,
  mutation: MutationType
)

ApplicationSchema.instance_exec do
  CustomGraphQLErrors::Error.descendants.each do |error_klass|
    rescue_from error_klass, &:message
  end

  rescue_from Pundit::NotAuthorizedError do
    ::I18n.t('pundit.errors.message.not_authorized')
  end
end
