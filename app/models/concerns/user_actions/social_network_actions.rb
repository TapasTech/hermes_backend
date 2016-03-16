# frozen_string_literal: true
module UserActions
  # all actions related to user social network
  module SocialNetworkActions
    extend ActiveSupport::Concern

    included do
      has_many :follower_followments, foreign_key: :followee_id,
                                      class_name: 'Followment'
      has_many :followers, class_name: 'User',
                           through: :follower_followments,
                           inverse_of: :followees

      has_many :followments, foreign_key: :follower_id
      has_many :followees, class_name: 'User',
                           through: :followments,
                           inverse_of: :followers

      delegate :count, to: :followers, prefix: true
      delegate :count, to: :followees, prefix: true
    end

    def follow(followee)
      followees << followee
    end

    def unfollow(followee)
      followees.destroy(followee)
    end

    def followed_by?(user)
      followers.exists?(user&.id)
    end
  end
end
