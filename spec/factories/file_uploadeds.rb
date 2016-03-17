# frozen_string_literal: true
FactoryGirl.define do
  factory :file_uploaded do
    sequence(:name) { |n| "file#{n}.zip" }
    sequence(:size) { |n| 1024 * n }
    sequence(:description) { |n| "The #{n}#{n.ordinal} data pack." }
    format 'zip'
    sequence(:url) { |n| "http://data.sayindata.com/2016/file#{n}.zip" }
  end
end
