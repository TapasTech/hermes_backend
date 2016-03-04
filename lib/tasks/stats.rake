# frozen_string_literal: true
task stats: 'stats:setup'

namespace :stats do
  task :setup do
    require 'rails/code_statistics'
    ::STATS_DIRECTORIES << ['Policies', 'app/policies']
    ::STATS_DIRECTORIES << ['Graph', 'app/graph']
  end
end
