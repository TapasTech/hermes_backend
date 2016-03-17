# frozen_string_literal: true
namespace :counter_culture do
  desc 'Fix counter caches'
  task fix_counts: :environment do
    Comment.counter_culture_fix_counts
    Answer.counter_culture_fix_counts
    Question.counter_culture_fix_counts
    Followment.counter_culture_fix_counts
  end
end
