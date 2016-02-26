class Business < ApplicationRecord
  acts_as_paranoid

  has_many :child_businesses, class_name: 'Business', foreign_key: 'parent_business_id'
  belongs_to :parent_business, class_name: 'Business', required: false

  has_many :users

  validates :name, presence: true
end
