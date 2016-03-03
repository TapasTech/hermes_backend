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
    gender ''
    bussiness nil
  end
end
