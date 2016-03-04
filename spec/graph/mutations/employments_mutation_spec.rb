# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EmploymentsMutation do
  subject { described_class }
  let(:employment) { create(:employment) }

  describe '::UpdateEmploymentField' do
    let(:resolution) do
      ::EmploymentsMutation::UpdateEmploymentField.resolve(
        employment,
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
