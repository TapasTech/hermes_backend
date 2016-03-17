# frozen_string_literal: true
FactoryGirl.define do
  factory :data_set do
    user
    sequence(:title, 2015) { |n| "#{n}年1月上海居民消费价格" }
    sequence(:url) { |n| "http://www.stats-sh.gov.cn/sjfb/201602/287166.html?nonsense=#{n}" }

    factory :data_set_with_files do
      transient do
        file_count 5
      end

      after(:create) do |data_set, evaluator|
        create_list(:file_uploaded, evaluator.file_count, uploadable: data_set)
      end
    end
  end
end
