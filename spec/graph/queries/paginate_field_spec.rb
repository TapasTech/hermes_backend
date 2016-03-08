# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PaginateField do
  subject { described_class }

  # Dummy Policy
  class PaginateFieldDummyModelPolicy < ApplicationPolicy
    def show?
      true
    end

    # Authorized Visible Scope
    class Scope < Scope
      def resolve
        scope
      end
    end
  end

  PaginateFieldDummyModel =
    Struct.new(:id, :name) do
      def self.name
        'Dummy'
      end

      def self.all
        Kaminari.paginate_array(PaginateFieldDummyData.values)
      end

      def self.page(page)
        all.page(page)
      end
    end

  PaginateFieldDummyData =
    {
      1 => PaginateFieldDummyModel.new(id: 1, name: '1'),
      2 => PaginateFieldDummyModel.new(id: 2, name: '2'),
      3 => PaginateFieldDummyModel.new(id: 3, name: '3')
    }.freeze

  PaginateFieldDummyModelType = GraphQL::ObjectType.define do
    name 'PaginateFieldDummyModel'

    field :id, types.String
    field :name, types.String
  end

  let(:field) { described_class.create(PaginateFieldDummyModel) }
  let(:resolution) do
    field.resolve(
      nil,
      GraphQL::Query::Arguments.new(arguments),
      context)
  end

  describe 'resolver' do
    let(:arguments) { {page: 1, count: 1} }
    let(:context) { {} }

    before do
      PaginateFieldDummyModelPolicy::Scope.class_eval do
        def resolve
          scope
        end
      end
    end

    context 'with proper setup' do
      

      it 'resolves great' do
        expect(resolution).to eq(PaginateFieldDummyModel.page(arguments[:page]).per(arguments[:count]))
      end
    end

    context 'with transformer' do
      let(:transformer) { ->(array) { array.map(&:name) } }
      let(:field) { described_class.create(PaginateFieldDummyModel, transform: transformer) }

      it 'resolves great' do
        expect(resolution).to eq(transformer.call(PaginateFieldDummyModel.page(arguments[:page]).per(arguments[:count])))
      end
    end
  end

  describe 'policy' do
    let(:arguments) { {page: 1, count: 1} }

    before do
      PaginateFieldDummyModelPolicy::Scope.class_eval do
        def resolve
          user.present? ? scope : []
        end
      end
    end

    context 'with current user' do
      let(:context) { {current_user: create(:user)} }

      it 'resolves great' do
        expect(resolution).to eq(PaginateFieldDummyModel.page(arguments[:page]).per(arguments[:count]))
      end
    end

    context 'without current user' do
      let(:context) { {} }

      it 'returns []' do
        expect(resolution).to eq([])
      end
    end
  end
end
