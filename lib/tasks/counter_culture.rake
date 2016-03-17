# frozen_string_literal: true
namespace :counter_culture do
  model_klasses = %w(
    comment
    answer
    question
    followment
    questions_followment
  )

  desc 'Fix counter caches'
  task fix_counts: model_klasses.map { |klass| "fix_counts:#{klass}" }

  namespace :fix_counts do
    model_klasses.each do |model_klass|
      model_name = model_klass.camelize
      desc "Fix counter caches of #{model_name}"
      task "#{model_klass}": :environment do
        model_name.constantize.counter_culture_fix_counts
        puts "Finished fix #{model_name}"
      end
    end
  end
end
