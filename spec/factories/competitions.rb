# frozen_string_literal: true
FactoryGirl.define do
  factory :competition do
    sequence(:title) { |n| "第#{n}次工商银行顾客满意度调查" }
    start_at         Time.zone.now - 1.month
    expire_at        Time.zone.now + 1.month
    competition_type :competition
    description      '对于一线面向客户的支持团队来说, 客户的满意度是成功的关键. 不开心的客户不会坚持使用产品, 更甚的是, 不开心的客户在离开前都不表达不满.'
    logo_url         'https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png'
    award            20_000
    data_set

    factory :competition_with_solutions do
      transient do
        solution_count 5
      end

      after(:create) do |competition, evaluator|
        create_list(:solution_with_files, evaluator.solution_count, competition: competition)
      end
    end
  end
end
