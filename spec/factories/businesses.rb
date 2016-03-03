# frozen_string_literal: true
FactoryGirl.define do
  sequence :business_name do |n|
    "行业#{n}"
  end

  factory :business do
    name { generate(:business_name) }
    parent_business nil

    factory :business_with_children do
      name { "父#{generate(:business_name)}" }

      transient do
        child_count 5
      end

      after(:create) do |business, evaluator|
        create_list(:business, evaluator.child_count, parent_business: business)
      end
    end
  end
end
