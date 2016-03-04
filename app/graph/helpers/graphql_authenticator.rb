# frozen_string_literal: true
# Authenticate user in GraphQL
GraphQLAuthenticator = Struct.new(:object, :arguments, :context) do
  def authenticate(&block)
    authenticate_user!

    execute(&block)
  end

  def execute(&block)
    instance_exec(object, arguments, context, &block) if block_given?
  end

  def authenticate_user!
    fail CustomGraphQLErrors::AuthenticationError if current_user.blank?
  end

  def current_user
    @current_user ||= context&.[] :current_user
  end

  # Module Methods
  module ModuleMethods
    def authenticate(object, arguments, context, &block)
      authenticator = new(object, arguments, context)
      authenticator.authenticate(&block)
    end

    def execute(object, arguments, context, &block)
      authenticator = new(object, arguments, context)
      authenticator.execute(&block)
    end
  end

  extend ModuleMethods
end
