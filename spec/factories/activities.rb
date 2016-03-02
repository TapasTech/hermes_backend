# frozen_string_literal: true
FactoryGirl.define do
  factory :activity do
    user nil
    question nil
    answer nil
    payload ''
    verb 'MyString'
  end
end