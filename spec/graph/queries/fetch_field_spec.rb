# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FetchField do
  subject { described_class }

  FetchFieldDummyModelPolicy =
    Struct.new(:user, :record) do
      def show?
        true
      end
    end

  FetchFieldDummyModelStrictPolicy =
    Struct.new(:user, :record) do
      def show?
        user.present?
      end
    end

  FetchFieldDummyModel =
    Struct.new(:id, :name) do
      def self.name
        'Dummy'
      end

      def self.find(id)
        FetchFieldDummyData[id]
      end
    end

  FetchFieldDummyData =
    {
      1 => FetchFieldDummyModel.new(id: 1, name: '1'),
      2 => FetchFieldDummyModel.new(id: 2, name: '2')
    }.freeze

  let(:field) { described_class.create(FetchFieldDummyModel) }
  let(:resolution) do
    field.resolve(
      nil,
      GraphQL::Query::Arguments.new(arguments),
      context)
  end

  describe 'resolver' do
    let(:arguments) { {id: 1} }
    let(:context) { {} }

    context 'with proper setup' do
      before do
        def FetchFieldDummyModel.policy_class
          FetchFieldDummyModelPolicy
        end
      end

      it 'resolves great' do
        expect(resolution).to eq(FetchFieldDummyData[arguments[:id]])
      end
    end

    context 'with transformer' do
      let(:transformer) { ->(record) { record.id } }
      let(:field) { described_class.create(FetchFieldDummyModel, transform: transformer) }

      it 'transforms resolution' do
        expect(resolution).to eq(transformer.call(FetchFieldDummyData[arguments[:id]]))
      end
    end
  end

  describe 'policy' do
    let(:arguments) { {id: 1} }

    before do
      def FetchFieldDummyModel.policy_class
        FetchFieldDummyModelStrictPolicy
      end
    end

    context 'with current user' do
      let(:context) { {current_user: create(:user)} }

      it 'resolves great' do
        expect(resolution).to eq(FetchFieldDummyData[arguments[:id]])
      end
    end

    context 'without current user' do
      let(:context) { {} }

      it 'raises Pundit::NotAuthorizedError' do
        expect { resolution }.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
