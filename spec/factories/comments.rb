# frozen_string_literal: true
FactoryGirl.define do
  factory :comment do
    user nil
    reply_to_id 1
    answer nil
    content 'MyString'
  end
end
