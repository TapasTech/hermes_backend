class Employment < ApplicationRecord
  belongs_to :user

  validates :employment, presence: true
end
