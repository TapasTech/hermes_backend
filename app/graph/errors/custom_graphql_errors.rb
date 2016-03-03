# frozen_string_literal: true
module CustomGraphQLErrors
  class Error < StandardError; end

  class AuthenticationError < Error; end
end
