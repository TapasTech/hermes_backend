# frozen_string_literal: true
module CustomGraphQLErrors
  BASE_KEY = 'graphql.errors.messages'
  # Basic Error
  class Error < StandardError
    attr_reader :error_key, :message

    def error_key
      @error_key ||= self.class.name.underscore.tr('/', '.')
    end

    def message
      @message ||= ::I18n.t("#{BASE_KEY}.#{error_key}")
    end
  end

  class AuthenticationError < Error; end
  class WrongPasswordError < Error; end
end
