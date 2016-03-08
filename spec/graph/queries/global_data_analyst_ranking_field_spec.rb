# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GlobalDataAnalystRankingField do
  subject { described_class }

  let(:resolution) do
    described_class.resolve(
      nil,
      GraphQL::Query::Arguments.new(arguments),
      context)
  end

  let(:arguments) { {page: 1, count: 10} }
  let(:answers) { create_list(:answer, 10) }
  let(:voters) { create_list(:user, 11) }

  before do
    (0..9).each do |index_a|
      (index_a + 1).times do |index_v|
        voters[index_v].vote_up_answer(answers[index_a])
      end
    end
  end

  describe 'resolve' do
    let(:context) { {current_user: create(:user)} }
    let(:confidences) { resolution.map(&:confidence) }

    it 'resolves answerers desc order by confidence' do
      expect(resolution).to eq(answers.reverse.map(&:user))
      expect(confidences).to eq(confidences.sort.reverse)
    end
  end
end
