# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AuthTokensMutation do
  subject { described_class }
  let(:user) { create(:user) }
  let(:auth_token) { resolution.auth_token }

  describe '::CreateAuthTokenField' do
    let(:resolution) do
      ::AuthTokensMutation::CreateAuthTokenField.resolve(
        nil,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          email: user.email,
          password: user.password
        }
      end

      let(:current_user) { nil }

      it 'resolves correctly' do
        expect(resolution.user).to eq(user)
        expect(AuthToken.from_token(auth_token).user).to eq(user)
      end
    end
  end

  describe '::RenewAuthTokenField' do
    let(:resolution) do
      ::AuthTokensMutation::RenewAuthTokenField.resolve(
        nil,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) { {} }

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution.user).to eq(user)
        expect(AuthToken.from_token(auth_token).user).to eq(user)
      end
    end
  end
end
