# frozen_string_literal: true
Redis::Objects.redis = ConnectionPool.new(Settings.redis_objects&.pool.to_h) do
  Redis.new(Settings.redis_objects&.client.to_h)
end
