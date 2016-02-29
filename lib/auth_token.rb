# frozen_string_literal: true
class AuthToken
  attr_accessor :user_id, :expires_at, :password_digest
  attr_reader :user
  DEFAULT_EXPIRES_IN = 1.week
  def initialize(user_id, password_digest, expires_at=Time.zone.now + DEFAULT_EXPIRES_IN)
    self.user_id = user_id.to_s
    self.expires_at = expires_at
    self.password_digest = password_digest.to_s
  end

  def generate
    AuthToken.verifier.generate('user_id' => user_id,
                                'expires_at' => expires_at,
                                'password_digest' => password_digest)
  end

  def valid?
    verify.present?
  end

  # return false if expired or user not match
  # return user  if user exists and password not changed
  def verify
    return false unless expires_at >= Time.zone.now
    user.present? && user.password_digest == password_digest ? user : false
  end

  def user
    @user ||= User.where(id: user_id).first
  end

  def renew(expires_at=Time.zone.now + DEFAULT_EXPIRES_IN)
    tap do |token|
      token.expires_at = expires_at
    end
  end

  class << self
    attr_reader :verifier

    def verifier
      @verifier ||=
        ActiveSupport::MessageVerifier.new Rails.application.secrets.secret_key_base,
                                           serializer: MultiJson
    end

    def from_token(token)
      message = verifier.verify token
      AuthToken.new(message['user_id'], message['password_digest'], message['expires_at'])
    end
  end
end
