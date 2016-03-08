# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SearchQuestionField do
  subject { described_class }

  let(:resolution) do
    SearchQuestionField.resolve(
      nil,
      GraphQL::Query::Arguments.new(arguments),
      context)
  end

  before do
    create_list(:question, 3)
    create_list(:question_blank, 7)
  end

  describe 'resolve' do
    context 'with valid query' do
      let(:arguments) { {query: '化妆品', page: 1, count: 10} }
      let(:context) { {current_user: create(:user)} }

      it 'resolves questions only containing keyword in title' do
        expect(resolution.size).to eq(3)
        expect(resolution.map { |q| q.title.include?(arguments[:query]) }).to eq([true] * 3)
      end
    end
  end
end
