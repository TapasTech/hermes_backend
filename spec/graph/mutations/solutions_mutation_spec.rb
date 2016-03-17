# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SolutionsMutation do
  subject { described_class }
  let(:competition) { create(:competition) }

  describe '::CreateAnswerField' do
    let(:resolution) do
      ::SolutionsMutation::CreateSolutionField.resolve(
        competition,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          description: 'dummy description'
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          description: arguments[:description])
        expect(resolution.user).to eq(current_user)
        expect(resolution.competition).to eq(competition)
      end
    end
  end
end
