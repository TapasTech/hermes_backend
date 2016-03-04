# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AnswersMutation do
  subject { described_class }

  let(:answer) { create(:answer) }
  let(:data_set) { create(:data_set) }
  let(:data_report) { create(:data_report) }

  describe '::CreateAnswerField' do
    let(:resolution) do
      ::AnswersMutation::CreateAnswerField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:question) { create(:question) }
    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          content: '我是一个有深度的答案'
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          content: arguments[:content])
        expect(resolution.user).to eq(current_user)
        expect(resolution.question).to eq(question)
      end
    end
  end

  describe '::UpdateAnswerField' do
    let(:resolution) do
      ::AnswersMutation::UpdateAnswerField.resolve(
        answer,
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

  describe '::AddDataSetField' do
    let(:resolution) do
      ::AnswersMutation::AddDataSetField.resolve(
        answer,
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

  describe '::RemoveDataSetField' do
    let(:resolution) do
      ::AnswersMutation::RemoveDataSetField.resolve(
        answer,
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

  describe '::AddDataReportField' do
    let(:resolution) do
      ::AnswersMutation::AddDataReportField.resolve(
        answer,
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

  describe '::RemoveDataReportField' do
    let(:resolution) do
      ::AnswersMutation::RemoveDataReportField.resolve(
        answer,
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
      ::AnswersMutation::VoteUpField.resolve(
        answer,
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
      ::AnswersMutation::VoteDownField.resolve(
        answer,
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
