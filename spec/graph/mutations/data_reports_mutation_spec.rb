# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataReportsMutation do
  subject { described_class }

  let(:data_report) { create(:data_report) }

  describe '::CreateDataReportField' do
    let(:resolution) do
      ::DataReportsMutation::CreateDataReportField.resolve(
        nil,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          title: '2016 数据报告',
          url: 'http://data.report.com/'
        }
      end

      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          title: arguments[:title],
          url: arguments[:url])
        expect(resolution.user).to eq(current_user)
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
        {
          title: '2016 数据报告 Mk. II',
          url: 'http://data.report.com/2'
        }
      end

      let(:current_user) { data_report.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          title: arguments[:title],
          url: arguments[:url])
      end
    end
  end
end
