# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UsersMutation do
  subject { described_class }
  let(:user) { create(:user) }

  describe '::CreateUserField' do
    let(:resolution) do
      ::UsersMutation::CreateUserField.resolve(
        user,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    context 'with proper argument and context' do
      let(:arguments) do
        {
          displayName: 'Valid User',
          email: 'valid_user@user.com',
          description: 'I\'m Valid User',
          gender: 'male',
          password: '12345678'
        }
      end

      let(:current_user) { nil }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.id).to be_truthy
        expect(resolution).to have_attributes(
          display_name: arguments[:displayName],
          email: arguments[:email])
        expect(resolution.authenticate(arguments[:password])).to be_truthy
      end
    end

    context 'without displayName' do
      let(:arguments) do
        {
          email: 'valid_user@user.com',
          password: '12345678'
        }
      end

      let(:current_user) { nil }

      it 'raises ActiveRecord::RecordInvalid' do
        expect { resolution }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'without email' do
      let(:arguments) do
        {
          displayName: 'Valid User',
          password: '12345678'
        }
      end

      let(:current_user) { nil }

      it 'raises ActiveRecord::RecordInvalid' do
        expect { resolution }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'without password' do
      let(:arguments) do
        {
          displayName: 'Valid User',
          email: 'valid_user@user.com'
        }
      end

      let(:current_user) { nil }

      it 'raises ActiveRecord::RecordInvalid' do
        expect { resolution }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '::UpdateUserField' do
    let(:resolution) do
      ::UsersMutation::UpdateUserField.resolve(
        user,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    let(:proper_arguments) do
      {
        displayName: 'Neo Valid User',
        email: 'neo_valid_user@user',
        description: 'I\'m a Neo Valid User.',
        gender: 'male'
      }
    end

    context 'with proper argument and context' do
      let(:arguments) do
        proper_arguments
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          display_name: arguments[:displayName],
          email: arguments[:email],
          description: arguments[:description],
          gender: arguments[:gender].to_sym)
      end
    end

    context 'without displayName' do
      let(:arguments) do
        {
          email: 'neo_valid_user@user',
          description: 'I\'m a Neo Valid User.',
          gender: 'male'
        }
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        old_attributes = user.attributes.symbolize_keys
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          display_name: old_attributes[:display_name],
          email: arguments[:email])
      end
    end

    context 'without email' do
      let(:arguments) do
        {
          displayName: 'Neo Valid User',
          description: 'I\'m a Neo Valid User.',
          gender: 'male'
        }
      end

      let(:current_user) { user }

      it 'resolves correctly' do
        old_attributes = user.attributes.symbolize_keys
        expect(resolution).to be_truthy
        expect(resolution).to have_attributes(
          display_name: arguments[:displayName],
          email: old_attributes[:email])
      end
    end

    context 'as another user' do
      let(:arguments) do
        proper_arguments
      end

      let(:current_user) { create(:user) }

      it 'raises Pundit::NotAuthorizedError' do
        expect { resolution }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'as a visitor' do
      let(:arguments) do
        proper_arguments
      end

      let(:current_user) { nil }

      it 'raises CustomGraphQLErrors::AuthenticationError' do
        expect { resolution }.to raise_error(CustomGraphQLErrors::AuthenticationError)
      end
    end
  end

  describe '::FollowField' do
    let(:resolution) do
      ::UsersMutation::FollowField.resolve(
        user,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    let(:arguments) do
      {}
    end

    context 'with proper argument and context' do
      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.followers).to include(current_user)
      end
    end

    context 'as the user herself/himself' do
      let(:current_user) { user }

      it 'raises Pundit::NotAuthorizedError' do
        expect { resolution }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'as a visitor' do
      let(:current_user) { nil }

      it 'raises CustomGraphQLErrors::AuthenticationError' do
        expect { resolution }.to raise_error(CustomGraphQLErrors::AuthenticationError)
      end
    end
  end

  describe '::UnfollowField' do
    let(:resolution) do
      ::UsersMutation::UnfollowField.resolve(
        user,
        GraphQL::Query::Arguments.new(arguments),
        context)
    end

    let(:context) { {current_user: current_user} }

    let(:arguments) do
      {}
    end

    context 'with proper argument and context' do
      before do
        current_user.follow(user)
      end
      let(:current_user) { create(:user) }

      it 'resolves correctly' do
        expect(resolution).to be_truthy
        expect(resolution.followers).not_to include(current_user)
      end
    end

    context 'as a visitor' do
      let(:current_user) { nil }

      it 'raises CustomGraphQLErrors::AuthenticationError' do
        expect { resolution }.to raise_error(CustomGraphQLErrors::AuthenticationError)
      end
    end
  end
end
