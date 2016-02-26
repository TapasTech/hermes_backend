class Education < ApplicationRecord
  belongs_to :user

  validates :organization, presence: true
end
