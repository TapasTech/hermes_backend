# frozen_string_literal: true
class ApplicationController < ActionController::API
  def current_user
    http_authorization = request.headers['Http-Authorization'] || request.env['HTTP_AUTHORIZATION'] || params['auth_token']
    return nil if http_authorization.blank?

    auth_token = ::AuthToken.from_token http_authorization
    return nil unless auth_token.valid?

    auth_token.user
  end
end
