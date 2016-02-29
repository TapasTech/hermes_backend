# frozen_string_literal: true
module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
    has_many :users, through: :votes

    def up_votes_count
      votes.ups.sum(:weight)
    end

    def down_votes_count
      votes.downs.sum(:weight)
    end

    def total_votes_count
      votes.sum(:weight)
    end

    def vote_by(user, weight)
      vote = votes.find_or_initialize_by(user: user)
      vote.update!(weight: weight)
    end

    def unvote_by(user)
      votes.find_or_initialize_by(user: user).destroy!
    end
  end
end
