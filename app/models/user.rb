# frozen_string_literal: true
class User < ApplicationRecord
  acts_as_paranoid

  belongs_to :business, required: false
  has_secure_password

  validates :email, presence: true,
                    format: {with: /\A\S+@\S+.\S+\Z/}
  validates :display_name, presence: true

  has_many :locations
  has_many :employments
  has_many :educations

  def location
    locations.first || locations.build
  end

  def employment
    employments.first || employments.build
  end

  def education
    educations.first || educations.build
  end

  has_many :follower_followments, foreign_key: :followee_id,
                                  class_name: 'Followment'
  has_many :followers, class_name: 'User',
                       through: :follower_followments,
                       inverse_of: :followees

  has_many :followments, foreign_key: :follower_id
  has_many :followees, class_name: 'User',
                       through: :followments,
                       inverse_of: :followers

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :reply_comments, foreign_key: :reply_to_id
end
