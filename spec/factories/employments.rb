# frozen_string_literal: true
FactoryGirl.define do
  factory :employment do
    user
    sequence(:employment) { |n| "第#{n}数据服务公司" }
    position '数据分析师'
  end
end
