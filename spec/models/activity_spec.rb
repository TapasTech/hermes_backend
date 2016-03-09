# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Activity, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:question) { FactoryGirl.create :question }
  let(:user) { FactoryGirl.create :user }
  let(:answer) { FactoryGirl.create :answer }

  describe '.build_create_question_activity' do
    it 'should build activity into user with QUESTION_CREATE' do
      Activity.build_create_question_activity(user, question)
      expect(user.activities.first.question).to eq(question)
      expect(user.activities.first.verb).to eq(:QUESTION_CREATE)
    end
  end

  describe '.build_follow_question_activity' do
    it 'should build activity into user with QUESTION_FOLLOW' do
      Activity.build_follow_question_activity(user, question)
      expect(user.activities.first.question).to eq(question)
      expect(user.activities.first.verb).to eq(:QUESTION_FOLLOW)
    end
  end

  describe '.build_create_answer_activity' do
    it 'should build activity into user with ANSWER_CREATE' do
      Activity.build_create_answer_activity(user, answer)
      expect(user.activities.first.answer).to eq(answer)
      expect(user.activities.first.verb).to eq(:ANSWER_CREATE)
    end
  end

  describe '.build_vote_up_answer_activity' do
    it 'should build activity into user with ANSWER_VOTE_UP' do
      Activity.build_vote_up_answer_activity(user, answer)
      expect(user.activities.first.answer).to eq(answer)
      expect(user.activities.first.verb).to eq(:ANSWER_VOTE_UP)
    end
  end
end
