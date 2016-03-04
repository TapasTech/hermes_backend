# frozen_string_literal: true
require 'rails_helper'

RSpec.describe LocationsMutation do
  subject { described_class }
  let(:location) { create(:location) }

  describe '::UpdateLocationField' do
    let(:resolution) do
      ::LocationsMutation::UpdateLocationField.resolve(
        location,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          name: '一个好地方'
        }
      end

      let(:current_user) { location.user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          name: arguments[:name])
      end
    end
  end
end
