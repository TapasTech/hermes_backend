# frozen_string_literal: true
FactoryGirl.define do
  factory :education do
    user nil
    sequence(:organization) { |n| "国立第#{n}大学" }
    direction '信息学'
  end
end
