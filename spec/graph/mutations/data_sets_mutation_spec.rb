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
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
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
        {}
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
      end
    end
  end
end
