# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentsMutation do
  subject { described_class }

  let(:reply_to) { create(:user) }
  let(:comment) { create(:comment) }

  describe '::CreateCommentField' do
    let(:resolution) do
      ::CommentsMutation::CreateCommentField.resolve(
        answer,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:answer) { create(:answer) }
    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          content: '这是一个有态度的评论',
          reply_to_id: reply_to.id
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          content: arguments[:content])
        expect(resolution.user).to eq(current_user)
        expect(resolution.reply_to).to eq(reply_to)
        expect(resolution.answer).to eq(answer)
      end
    end
  end

  describe '::VoteUpField' do
    let(:resolution) do
      ::CommentsMutation::VoteUpField.resolve(
        comment,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect { resolution }
          .to change { comment.up_votes_count }
          .from(0).to(1)
      end
    end
  end

  describe '::VoteDownField' do
    let(:resolution) do
      ::CommentsMutation::VoteDownField.resolve(
        comment,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect { resolution }
          .to change { comment.down_votes_count }
          .from(0).to(1)
      end
    end
  end
end
