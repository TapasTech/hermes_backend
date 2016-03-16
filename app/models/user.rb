# frozen_string_literal: true
class User < ApplicationRecord
  include RedisObjectable
  include UserActions

  acts_as_paranoid
  has_secure_password

  GENDERS =
    %w(
      secret
      female
      male
      other
    ).freeze

  # profile
  as_enum :gender, GENDERS, map: :string, source: :gender
  belongs_to :business, required: false

  validates :email, presence: true,
                    format: {with: /\A\S+@\S+.\S+\Z/},
                    uniqueness: true
  validates :display_name, presence: true

  has_many :locations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :educations, dependent: :destroy

  def location
    locations.first || locations.build
  end

  def employment
    employments.first || employments.build
  end

  def education
    educations.first || educations.build
  end

  # Data Reports
  has_many :data_sets
  has_many :data_reports

  # activity feeds
  has_many :activities
end
