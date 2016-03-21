# frozen_string_literal: true
class Competition < ApplicationRecord
  acts_as_paranoid

  scope :active_when, ->(date) { where('start_at <= ? AND expire_at >= ?', date, date) }
  scope :inactive_when, ->(date) { where('expire_at < ?', date) }

  has_many :solutions
  has_one :data_set, -> { includes(:file_uploadeds) }

  delegate :file_uploadeds, to: :data_set

  TYPES =
    %w(
      competition
      recruitment
      report
    ).freeze

  as_enum :competition_type, TYPES, map: :string, source: :competition_type

  validates :title, presence: true
  validates :start_at, presence: true
  validates :expire_at, presence: true
  validates :competition_type, presence: true

  def open?
    Time.zone.now <= expire_at && Time.zone.now >= start_at
  end

  def my_solution(user)
    solutions.find_or_initialize_by(user: user)
  end
end
