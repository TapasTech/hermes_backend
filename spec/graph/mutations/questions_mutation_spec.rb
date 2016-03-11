# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QuestionsMutation do
  subject { described_class }
  let(:question) { create(:question) }
  let(:topic) { create(:topic) }
  let(:data_set) { create(:data_set) }
  let(:data_report) { create(:data_report) }

  describe '::CreateQuestionField' do
    let(:resolution) do
      ::QuestionsMutation::CreateQuestionField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:question) { nil }
    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:question) { nil }
      let(:arguments) do
        {
          title: '我是一个问题',
          content: '这是个很严肃的问题!'
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          title: arguments[:title],
          content: arguments[:content])
        expect(resolution.user).to eq(current_user)
      end
    end
  end

  describe '::UpdateQuestionField' do
    let(:resolution) do
      ::QuestionsMutation::UpdateQuestionField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          title: '我是一个问题! 更新!',
          content: '这个问题超级有价值!'
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          title: arguments[:title],
          content: arguments[:content])
        expect(resolution.user).to eq(current_user)
      end
    end
  end

  describe '::AddTopicField' do
    let(:resolution) do
      ::QuestionsMutation::AddTopicField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          id: topic.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.topics).to include(topic)
      end
    end
  end

  describe '::RemoveTopicField' do
    let(:resolution) do
      ::QuestionsMutation::RemoveTopicField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      before do
        question.topics << topic
      end

      let(:arguments) do
        {
          id: topic.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.topics).not_to include(:topic)
      end
    end
  end

  describe '::AddDataSetField' do
    let(:resolution) do
      ::QuestionsMutation::AddDataSetField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          id: data_set.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.data_sets).to include(data_set)
      end
    end
  end

  describe '::RemoveDataSetField' do
    let(:resolution) do
      ::QuestionsMutation::RemoveDataSetField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      before do
        question.data_sets << data_set
      end

      let(:arguments) do
        {
          id: data_set.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.data_sets).not_to include(data_set)
      end
    end
  end

  describe '::AddDataReportField' do
    let(:resolution) do
      ::QuestionsMutation::AddDataReportField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          id: data_report.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.data_reports).to include(data_report)
      end
    end
  end

  describe '::RemoveDataReportField' do
    let(:resolution) do
      ::QuestionsMutation::RemoveDataReportField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      before do
        question.data_reports << data_report
      end
      let(:arguments) do
        {
          id: data_report.id
        }
      end

      let(:current_user) { question.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.data_reports).not_to include(data_report)
      end
    end
  end

  describe '::VoteUpField' do
    let(:resolution) do
      ::QuestionsMutation::VoteUpField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect { resolution }
          .to change { question.up_votes_count }
          .from(0).to(1)
      end
    end
  end

  describe '::VoteDownField' do
    let(:resolution) do
      ::QuestionsMutation::VoteDownField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect { resolution }
          .to change { question.down_votes_count }
          .from(0).to(1)
      end
    end
  end

  describe '::FollowField' do
    let(:resolution) do
      ::QuestionsMutation::FollowField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.followers).to include(current_user)
      end
    end
  end

  describe '::UnfollowField' do
    let(:resolution) do
      ::QuestionsMutation::UnfollowField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      before do
        question.followers << current_user
      end

      let(:arguments) { {} }
      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.followers).not_to include(current_user)
      end
    end
  end

  describe '::ReadField' do
    let(:resolution) do
      ::QuestionsMutation::ReadField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      before do
        @read_count = question.read_count.value
      end

      let(:arguments) { {} }
      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution.read_count.value).to eq(@read_count + 1)
      end
    end
  end
end
