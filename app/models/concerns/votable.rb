# frozen_string_literal: true
module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable
    has_many :users, through: :votes
  end
end
