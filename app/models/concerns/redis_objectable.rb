# frozen_string_literal: true
module RedisObjectable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects unless included_modules.include?(Redis::Objects)
  end
end
