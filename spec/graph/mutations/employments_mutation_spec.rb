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
        {
          employment: '一所好公司',
          position: '一个好职位'
        }
      end

      let(:current_user) { employment.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          employment: arguments[:employment],
          position: arguments[:position])
      end
    end
  end
end
