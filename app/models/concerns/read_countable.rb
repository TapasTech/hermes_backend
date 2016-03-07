# frozen_string_literal: true
module ReadCountable
  extend ActiveSupport::Concern
  include RedisObjectable

  included do
    counter :read_count
  end

  def read
    read_count.increment
  end
end
