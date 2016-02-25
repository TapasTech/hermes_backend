class User < ApplicationRecord
  belongs_to :business
  has_secure_password

  has_many :locations
  has_many :employments
  has_many :educations

  has_many :follower_followments, foreign_key: :followee_id,
                                  class_name: 'Followment'
  has_many :followers, class_name: 'User',
                       through: :follower_followments,
                       inverse_of: :followees

  has_many :followments, foreign_key: :follower_id
  has_many :followees, class_name: 'User',
                       through: :followments,
                       inverse_of: :followers

  validates :email, presence: true
  validates :display_name, presence: true
end
