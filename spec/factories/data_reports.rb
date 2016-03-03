# frozen_string_literal: true
FactoryGirl.define do
  factory :data_report do
    sequence(:title, 2015) { |n| "天猫美妆: #{n}中国美妆消费趋势报告" }
    sequence(:url) { |n| "http://datareport.dtcj.com/pdf?name=2016%E4%B8%AD%E5%9B%BD%E7%BE%8E%E5%A6%86%E6%B6%88%E8%B4%B9%E8%B6%8B%E5%8A%BF%E6%8A%A5%E5%91%8A&report_path=http://images.dtcj.com/DTCJ/e130c46e4a9a6d2db857c4e5861ab36c2157d7b060eeefcd71eb247a56cdab9f&total_pages_num=99&seq=#{n}" }
  end
end
