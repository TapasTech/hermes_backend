# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MeField do
  subject { described_class }

  let(:resolution) { MeField.resolve(nil, nil, context) }
  describe 'resolve' do
    context 'with current user' do
      let(:context) { {current_user: create(:user)} }
      it 'resolves current user' do
        expect(resolution).to eq(context[:current_user])
      end
    end

    context 'without current user' do
      let(:context) { {} }
      it 'raises CustomGraphQLErrors::AuthenticationError' do
        expect { resolution }.to raise_error(CustomGraphQLErrors::AuthenticationError)
      end
    end
  end
end
