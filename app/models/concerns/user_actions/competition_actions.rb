# frozen_string_literal: true
module UserActions
  # all actions related to user competition
  module CompetitionActions
    extend ActiveSupport::Concern

    included do
      has_many :solutions
    end

    def participate(description:, competition:)
      solution = solutions.find_or_initialize_by(competition: competition)
      solution.description = description
      solution
    end
  end
end
