# frozen_string_literal: true
FactoryGirl.define do
  factory :questions_followment do
    follower_id 1
    followee_question_id 1
  end
end
