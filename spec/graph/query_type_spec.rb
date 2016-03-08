# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QueryType do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      user
      me
      topic
      topics
      question
      questions
      answer
      comment
      dataSets
      dataReports
      hotAnswers
      bestAnalysts
      searchQuestions
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
    end
  end
end
