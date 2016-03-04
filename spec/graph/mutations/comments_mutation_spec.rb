# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommentsMutation do
  subject { described_class }
  let(:comment) { create(:comment) }

  describe '::CreateCommentField' do
    let(:resolution) do
      ::CommentsMutation::CreateCommentField.resolve(
        comment,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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
      let(:arguments) do
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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
      let(:arguments) do
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
      end
    end
  end
end
