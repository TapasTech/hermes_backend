# frozen_string_literal: true
FactoryGirl.define do
  factory :activity do
    user
    question
    answer
    payload nil
    verb nil
  end
end
