# frozen_string_literal: true
FactoryGirl.define do
  factory :solution do
    user
    competition
    description '这题应该这样搞'

    factory :solution_with_files do
      transient do
        file_count 5
      end

      after(:create) do |solution, evaluator|
        create_list(:file_uploaded, evaluator.file_count, uploadable: solution)
      end
    end
  end
end
