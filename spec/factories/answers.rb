# frozen_string_literal: true
FactoryGirl.define do
  factory :answer do
    user ''
    question nil
    content 'MyString'
  end
end
