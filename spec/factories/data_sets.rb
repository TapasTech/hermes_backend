# frozen_string_literal: true
FactoryGirl.define do
  factory :data_set do
    sequence(:title, 2015) { |n| "#{n}年1月上海居民消费价格 " }
    sequence(:url) { |n| "http://www.stats-sh.gov.cn/sjfb/201602/287166.html?nonsense=#{n}" }
  end
end
