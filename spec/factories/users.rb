# frozen_string_literal: true
FactoryGirl.define do
  sequence :email do |n|
    "n_data_#{n}@yicai.com"
  end

  sequence :display_name do |n|
    "n_data_#{n}"
  end

  factory :user do
    email
    password '12345678'
    display_name
    description { "I'm #{display_name}" }
    gender ''
    business nil
    locations []
    educations []
    employments []
    data_sets []
    data_reports []

    factory :user_with_full_profile do
      business

      after(:create) do |user, _evaluator|
        create(:location, user: user)
        create(:education, user: user)
        create(:employment, user: user)
      end
    end
  end
end
