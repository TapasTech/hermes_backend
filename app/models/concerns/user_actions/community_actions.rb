# frozen_string_literal: true
module UserActions
  # all actions related to user community
  module CommunityActions
    extend ActiveSupport::Concern

    included do
      # community
      has_many :questions
      has_many :answers
      has_many :comments

      ## Comments reply to you
      has_many :reply_comments, class_name: 'Comment',
                                foreign_key: :reply_to_id

      has_many :questions_followments, foreign_key: :follower_id
      has_many :followee_questions, class_name: 'Question',
                                    through: :questions_followments,
                                    inverse_of: :followers

      ## Votes get from answer
      counter :up_votes_count
      counter :down_votes_count
    end

    def good_at_topics
      question_ids = answers.map(&:question_id)
      topics_with_count = Question.where('questions.id in (?)', question_ids).joins(:topics).group('topics.id').count
      topic_ids = topics_with_count.sort_by { |topic_with_count| topic_with_count[1] }.reverse[0, 3]
      Topic.find(topic_ids)
    end

    def sum_votes!
      user_answers = answers.select(:id)
      up_votes_count.reset user_answers.map(&:up_votes_count).reduce
      down_votes_count.reset user_answers.map(&:down_votes_count).reduce
      [up_votes_count.value, down_votes_count.value]
    end

    def update_rank!
      up_votes, down_votes = [up_votes_count.value, down_votes_count.value].map(&:to_i)
      update!(confidence: Rankable.confidence(up_votes, up_votes + down_votes))
    end

    ## Community actions

    def ask(title:, content: nil)
      question = questions.create!(title: title, content: content)
      Activity.create_create_question_activity!(self, question)
      question
    end

    # one question should be answered only once
    def answer(content:, question:)
      answer = answers.find_or_initialize_by(question: question)
      answer.update!(content: content)
      Activity.create_create_answer_activity!(self, answer)
      answer
    end

    def follow_question(question)
      followee_questions << question
      Activity.create_follow_question_activity!(self, question)
    end

    def unfollow_question(question)
      followee_questions.destroy(question)
    end

    def vote_up_question(question)
      question.vote_by(self, 1)
    end

    def vote_down_question(question)
      question.vote_by(self, -1)
    end

    def vote_up_answer(answer)
      return if answer.up_vote_by? self
      answer.vote_by(self, 1)
      answer.user.up_votes_count.increment
      answer.user.update_rank!
      Activity.create_vote_up_answer_activity!(self, answer)
    end

    def vote_down_answer(answer)
      return if answer.down_vote_by? self
      answer.vote_by(self, -1)
      answer.user.down_votes_count.increment
      answer.user.update_rank!
    end

    def vote_up_comment(comment)
      comment.vote_by(self, 1)
    end

    def vote_down_comment(comment)
      comment.vote_by(self, -1)
    end
  end
end
