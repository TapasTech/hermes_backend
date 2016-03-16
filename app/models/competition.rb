# frozen_string_literal: true
class Competition < ApplicationRecord
  acts_as_paranoid

  scope :active_when, ->(date) { where('start_at <= ? AND expire_at >= ?', date, date) }

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
    ActiveSupport::TimeZone.now <= expire_at && ActiveSupport::TimeZone.now >= start_at
  end
end
