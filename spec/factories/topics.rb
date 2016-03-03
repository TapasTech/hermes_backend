# frozen_string_literal: true
FactoryGirl.define do
  factory :topic do
    sequence(:name) { |n| "话题#{n}" }
    description { "一起来讨论#{name}" }
    origin_id nil

    factory :topic_with_aliases do
      transient do
        alias_count 5
      end

      after(:create) do |topic, evaluator|
        create_list(:topic, evaluator.alias_count, origin: topic)
      end
    end
  end
end
