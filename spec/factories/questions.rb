# frozen_string_literal: true
FactoryGirl.define do
  factory :question do
    user
    title '中国高端化妆品市场走势在2016将会怎么样?'
    content '刚看了天猫美妆发布的趋势报告, 想看看大牛如何解读'
    topics []
    answers []

    factory :question_with_answers do
      transient do
        answer_count 5
      end

      after(:create) do |question, evaluator|
        create_list(:question, evaluator.answer_count, question: question)
      end
    end
  end
end
