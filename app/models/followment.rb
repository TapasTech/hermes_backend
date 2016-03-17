# frozen_string_literal: true
class Followment < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  counter_culture :follower, column_name: 'followees_count'
  belongs_to :followee, class_name: 'User'
  counter_culture :followee, column_name: 'followers_count'
end
