# frozen_string_literal: true
module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
    has_many :users, through: :votes

    # Countable
    def up_votes_count
      votes.ups.sum(:weight)
    end

    def down_votes_count
      votes.downs.sum(:weight)
    end

    def seperate_votes_counts
      weights = votes.group(:weight).sum(:weight)
      {
        -1 => weights.select { |w, _total_w| w < 0 }
                     .lazy.map { |_w, total_w| total_w }
                     .reduce(&:+) || 0,
        1 => weights.select { |w, _total_w| w > 0 }
                    .lazy.map { |_w, total_w| total_w }
                    .reduce(&:+) || 0
      }
    end

    def total_votes_count
      votes.sum(:weight)
    end

    # Votable
    def vote_by(user, weight)
      vote = votes.find_or_initialize_by(user: user)
      vote.update!(weight: weight)
      update_rank!
    end

    def unvote_by(user)
      votes.find_or_initialize_by(user: user).destroy!
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

      left = phat + 1 / (2 * total) * z * z
      right = z * Math.sqrt(phat * (1 - phat) / total + z * z / (4 * total * total))
      under = 1 + 1 / total * z * z

      (left - right) / under
    end
  end
  extend ConfidentAnswer
end
