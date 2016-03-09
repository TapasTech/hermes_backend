# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let(:user) { FactoryGirl.create :user }
  describe '#ask' do
    it 'ask one question' do
      question = user.ask(title: 'dummy question')
      expect(question.title).to eq('dummy question')
      expect(user.activities.where(question: question).first).not_to eq(nil)
    end
  end

  describe '#answer' do
    let(:question) { FactoryGirl.create(:question) }

    context 'when answer question firstly' do
      it 'answer one new answer' do
        answer = user.answer(content: 'dummy answer content', question: question)
        expect(answer.content).to eq('dummy answer content')
        activity = user.activities.where(question: question, answer: answer).first
        expect(activity).not_to eq(nil)
      end
    end

    context 'when answer question secondly' do
      it 'answer one new answer' do
        answer = user.answer(content: 'dummy new content', question: question)
        expect(answer.content).to eq('dummy new content')
        expect(user.answers.where(question: question).count).to eq(1)
      end
    end
  end

  describe '#vote_up_answer' do
    let(:answer) { FactoryGirl.create :answer }

    context 'when vote up answer firstly' do
      subject(:answer_voted) do
        user.vote_up_answer answer
        answer
      end

      it "answer's user vote up count increment" do
        expect(answer_voted.user.up_votes_count.value).to eq(1)
      end

      it "answer's user rank updated" do
        expect(answer_voted.user.confidence).not_to eq(nil)
      end
    end

    context 'when vote up answer secondly' do
      subject(:answer_voted) do
        user.vote_up_answer answer
        answer
      end

      it "answer's user vote up count not increment" do
        expect(answer_voted.user.up_votes_count.value).not_to eq(2)
      end

      it 'user exist in answer up voters set' do
        expect(answer_voted.up_vote_by?(user)).to eq(true)
      end
    end
  end

  describe '#vote_down_answer' do
    let(:answer) { FactoryGirl.create :answer }

    context 'when vote down answer firstly' do
      subject(:answer_voted) do
        user.vote_down_answer answer
        answer
      end

      it "answer's user vote down count increment" do
        expect(answer_voted.user.down_votes_count.value).to eq(1)
      end

      it "answer's user rank updated" do
        expect(answer_voted.user.confidence).not_to eq(nil)
      end
    end

    context 'when vote down answer secondly' do
      subject(:answer_voted) do
        user.vote_down_answer answer
        answer
      end

      it "answer's user vote down count not increment" do
        expect(answer_voted.user.down_votes_count.value).not_to eq(2)
      end

      it 'user exist in answer down voters set' do
        expect(answer_voted.down_vote_by?(user)).to eq(true)
      end
    end
  end
end
