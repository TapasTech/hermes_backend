# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataReportsMutation do
  subject { described_class }
  let(:data_report) { create(:data_report) }

  describe '::CreateDataReportField' do
    let(:resolution) do
      ::DataReportsMutation::CreateDataReportField.resolve(
        data_report,
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

  describe '::UpdateDataReportField' do
    let(:resolution) do
      ::DataReportsMutation::UpdateDataReportField.resolve(
        data_report,
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
