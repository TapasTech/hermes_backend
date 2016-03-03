# frozen_string_literal: true
FactoryGirl.define do
  factory :comment do
    user
    reply_to_id nil
    answer nil
    sequence(:content) { |n| "分析得不错#{n}" }
  end
end
