# frozen_string_literal: true
module ReadCountable
  extend ActiveSupport::Concern

  included do
    include Redis::Objects unless included_modules.include?(Redis::Objects)
    counter :read_count

    def read
      read_count.increment
    end
  end
end
