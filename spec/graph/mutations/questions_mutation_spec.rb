# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QuestionsMutation do
  let(:question) do
    # load record
  end
  subject { described_class }

  describe '::CreateQuestionField' do
    let(:resolution) do
      ::QuestionsMutation::CreateQuestionField.resolve(
        question,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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

    let(:question) { create(:question) }

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          # arguments
        }
      end

      let(:current_user) do
        # Load User
      end

      it 'resolves correctly' do
        expect(resolution).to be_truthy
      end
    end
  end
end
