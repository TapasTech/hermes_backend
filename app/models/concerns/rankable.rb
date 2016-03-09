# frozen_string_literal: true
module Rankable
  extend ActiveSupport::Concern
  include RedisObjectable

  included do
    set :up_voters
    set :down_voters

    delegate :key, to: :up_voters, prefix: true
    delegate :key, to: :down_voters, prefix: true

    after_create :update_rank!
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

  # Rankable
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

  def up_vote_by?(user)
    up_voters.member? user.id
  end

  def down_vote_by?(user)
    down_voters.member? user.id
  end

  # Rankable
  def calculate_hot
    weights = seperate_votes_counts
    Rankable.hot(weights[1], weights[-1], created_at)
  end

  def calculate_confidence
    weights = seperate_votes_counts
    Rankable.confidence(weights[1], weights[1] + weights[-1])
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
      z = 1.281551565545 # 80% confidence, 1.44 for 85%, 1.96 for 95%
      phat = ups.to_f / total

      params = [phat, total, z]
      (wilson_left(*params) - wilson_right(*params)) /
        wilson_under(*params)
    rescue Math::DomainError
      0
    end

    def wilson_left(phat, total, z)
      phat + 1 / (2 * total) * z**2
    end

    def wilson_right(phat, total, z)
      z * Math.sqrt(phat * (1 - phat) / total + z**2 / (4 * total**2))
    end

    def wilson_under(_phat, total, z)
      1 + 1 / total * z**2
    end
  end
  extend ConfidentAnswer
end
