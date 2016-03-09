# frozen_string_literal: true
class Activity < ApplicationRecord
  VERBS =
    %w(
      QUESTION_CREATE
      QUESTION_FOLLOW
      ANSWER_CREATE
      ANSWER_VOTE_UP
    ).freeze

  VERBS.each { |verb| const_set(verb, verb) }

  belongs_to :user
  belongs_to :question
  belongs_to :answer, required: false

  as_enum :verb, VERBS, map: :string, source: :verb
  validates :verb, presence: true

  # Factory methods for building activities
  module Factory
    # QUESTION_CREATE
    def build_create_question_activity(user, question)
      user.activities.build(question: question, verb: QUESTION_CREATE)
    end

    def create_create_question_activity!(user, question)
      build_create_question_activity(user, question).save!
    end

    # QUESTION_FOLLOW
    def build_follow_question_activity(user, question)
      user.activities.build(question: question, verb: QUESTION_FOLLOW)
    end

    def create_follow_question_activity!(user, question)
      build_follow_question_activity(user, question).save!
    end

    # ANSWER_CREATE
    def build_create_answer_activity(user, answer)
      user.activities.build(question: answer.question, answer: answer, verb: ANSWER_CREATE)
    end

    def create_create_answer_activity!(user, answer)
      build_create_answer_activity(user, answer).save!
    end

    # ANSWER_VOTE_UP
    def build_vote_up_answer_activity(user, answer)
      user.activities.build(question: answer.question, answer: answer, verb: ANSWER_VOTE_UP)
    end

    def create_vote_up_answer_activity!(user, answer)
      build_vote_up_answer_activity(user, answer).save!
    end
  end

  extend Factory
end
