# frozen_string_literal: true
module Votable
  extend ActiveSupport::Concern
  include RedisObjectable

  included do
    set :up_voters
    set :down_voters

    delegate :key, to: :up_voters, prefix: true
    delegate :key, to: :down_voters, prefix: true
  end

  # Countable
  def up_votes_count
    up_voters.count
  end

  def down_votes_count
    down_voters.count
  end

  def seperate_votes_counts
    {
      -1 => down_votes_count,
      1 => up_votes_count
    }
  end

  def total_votes_count
    up_votes_count - down_votes_count
  end

  # Votable
  def vote_by(user, weight)
    if weight > 0
      up_vote_by(user)
    elsif weight < 0
      down_vote_by(user)
    else
      unvote_by(user)
    end
  end

  def up_vote_by(user)
    redis.pipelined do
      redis.sadd up_voters_key,   user.id
      redis.srem down_voters_key, user.id
    end
    update_rank!
  end

  def down_vote_by(user)
    redis.pipelined do
      redis.sadd down_voters_key, user.id
      redis.srem up_voters_key,   user.id
    end
    update_rank!
  end

  def unvote_by(user)
    redis.pipelined do
      redis.srem up_voters_key,   user.id
      redis.srem down_voters_key, user.id
    end
    update_rank!
  end

  # Rankable
  def calculate_hot
    weights = seperate_votes_counts
    Votable.hot(weights[1], weights[-1], created_at)
  end

  def calculate_confidence
    weights = seperate_votes_counts
    Votable.confidence(weights[1], weights[1] - weights[-1])
  end

  def update_rank!
    update_hot_rank! if self.class.column_names.include?('hot')
    update_confidence_rank! if self.class.column_names.include?('confidence')
  end

  def update_hot_rank!
    update!(hot: calculate_hot)
  end

  def update_confidence_rank!
    update!(confidence: calculate_confidence)
  end

  # Calculate HOT answer
  module HotAnswer
    # reddit hot algorithm
    SINCE_DATE = 1_423_925_760.0 # 2016-02-14T14:56:00.000+08:00
    HOT_SCALE = 45_000

    def score(ups, downs)
      ups - downs
    end

    def epoch_seconds(date)
      date.to_f
    end

    def hot(ups, downs, date)
      score = score(ups, downs)
      order = Math.log([score, 1].max.abs, 10)
      sign = score <=> 0
      seconds = epoch_seconds(date) - SINCE_DATE
      (sign * order + seconds / HOT_SCALE).round(7)
    end
  end
  extend HotAnswer

  # Calculate the confidence of an answer
  module ConfidentAnswer
    # Wilson score interval
    def confidence(ups, total)
      return 0 if total == 0
      z = 1.44 # 1.44 is 85%, 1.96 is 95%
      phat = ups.to_f / total

      params = [phat, total, z]
      (wilson_left(*params) - wilson_right(*params)) /
        wilson_under(*params)
    end

    def wilson_left(phat, total, z)
      phat + 1 / (2 * total) * z * z
    end

    def wilson_right(phat, total, z)
      z * Math.sqrt(phat * (1 - phat) / total + z * z / (4 * total * total))
    end

    def wilson_under(_phat, total, z)
      1 + 1 / total * z * z
    end
  end
  extend ConfidentAnswer
end
