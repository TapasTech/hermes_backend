# frozen_string_literal: true
class User < ApplicationRecord
  include RedisObjectable
  acts_as_paranoid
  has_secure_password

  # profile
  belongs_to :business, required: false

  validates :email, presence: true,
                    format: {with: /\A\S+@\S+.\S+\Z/},
                    uniqueness: true
  validates :display_name, presence: true

  has_many :locations, dependent: :destroy
  has_many :employments, dependent: :destroy
  has_many :educations, dependent: :destroy

  def location
    locations.first || locations.build
  end

  def employment
    employments.first || employments.build
  end

  def education
    educations.first || educations.build
  end

  # social network
  has_many :follower_followments, foreign_key: :followee_id,
                                  class_name: 'Followment'
  has_many :followers, class_name: 'User',
                       through: :follower_followments,
                       inverse_of: :followees

  has_many :followments, foreign_key: :follower_id
  has_many :followees, class_name: 'User',
                       through: :followments,
                       inverse_of: :followers

  delegate :count, to: :followers, prefix: true
  delegate :count, to: :followees, prefix: true

  def follow(followee)
    followees << followee
  end

  def unfollow(followee)
    followees.destroy(followee)
  end

  # Data Reports
  has_many :data_sets
  has_many :data_reports

  # community
  has_many :questions
  has_many :answers
  has_many :comments
  ## Comments reply to you
  has_many :reply_comments, foreign_key: :reply_to_id

  has_many :questions_followments, foreign_key: :follower_id
  has_many :followee_questions, class_name: 'Question',
                                through: :questions_followments,
                                inverse_of: :followers

  delegate :count, to: :questions, prefix: true
  delegate :count, to: :answers, prefix: true

  ## Votes get from answer
  value :up_votes_count, marshal: true
  value :down_votes_count, marshal: true

  def sum_votes!
    user_answers = answers.select(:id)
    self.up_votes_count = user_answers.map(&:up_votes_count).reduce
    self.down_votes_count = user_answers.map(&:down_votes_count).reduce
    [up_votes_count, down_votes_count]
  end

  def sum_votes_and_update_rank!
    up_votes, down_votes = sum_votes!.map(&:to_i)
    update!(confidence: Rankable.confidence(up_votes, up_votes + down_votes))
  end

  ## Community actions

  def ask(title:, content: nil)
    question = questions.create!(title: title, content: content)
    Activity.create_create_question_activity!(self, question)
    question
  end

  def answer(content:, question:)
    answer = answers.create!(content: content, question: question)
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
    answer.vote_by(self, 1)
    answer.user.sum_votes_and_update_rank!
    Activity.create_vote_up_answer_activity!(self, answer)
  end

  def vote_down_answer(answer)
    answer.vote_by(self, -1)
    answer.user.sum_votes_and_update_rank!
  end

  def vote_up_comment(comment)
    comment.vote_by(self, 1)
  end

  def vote_down_comment(comment)
    comment.vote_by(self, -1)
  end

  # activity feeds
  has_many :activities
end
