# frozen_string_literal: true
FactoryGirl.define do
  factory :vote do
    user nil
    votable nil
    weight 1
  end
end
