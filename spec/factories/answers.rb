# frozen_string_literal: true
FactoryGirl.define do
  factory :answer do
    user
    question
    sequence(:content) { |n| "这是第#{n}个出色的回答!" }
    comments []

    factory :answer_with_comments do
      transient do
        comment_count 5
      end

      after(:create) do |answer, evaluator|
        create_list(:comment, evaluator.comment_count, answer: answer)
      end
    end
  end
end
