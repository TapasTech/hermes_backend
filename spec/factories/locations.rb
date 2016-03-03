# frozen_string_literal: true
FactoryGirl.define do
  factory :location do
    user
    sequence(:name) { |n| "#{n}番市" }
  end
end
