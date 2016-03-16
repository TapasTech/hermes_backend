# frozen_string_literal: true
class Competition < ApplicationRecord
  acts_as_paranoid

  has_many :solutions
  has_one :data_set, -> { includes(:file_uploadeds) }

  delegate :file_uploadeds, to: :data_set

  TYPES =
    %w(
      competition
      recruitment
      report
    ).freeze

  as_enum :type, TYPES, map: :string, source: :type

  validates :type, presence: true
end
