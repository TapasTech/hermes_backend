# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EducationsMutation do
  subject { described_class }
  let(:education) { create(:education) }

  describe '::UpdateEducationField' do
    let(:resolution) do
      ::EducationsMutation::UpdateEducationField.resolve(
        education,
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
