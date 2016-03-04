# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DataSetsMutation do
  subject { described_class }
  let(:data_set) { create(:data_set) }

  describe '::CreateDataSetField' do
    let(:resolution) do
      ::DataSetsMutation::CreateDataSetField.resolve(
        data_set,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          title: '2016 社区指数',
          url: 'http://data.set.com/'
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

  describe '::UpdateDataSetField' do
    let(:resolution) do
      ::DataSetsMutation::UpdateDataSetField.resolve(
        data_set,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          title: '2016 社区指数(修正版)',
          url: 'http://data.set.com/2'
        }
      end

      let(:current_user) { data_set.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          title: arguments[:title],
          url: arguments[:url])
      end
    end
  end
end
