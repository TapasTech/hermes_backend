# frozen_string_literal: true
require 'rails_helper'

RSpec.describe QuestionType, type: :model do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      user
      title
      content
      topics
      dataSets
      dataReports
      answers
      answersCount
      upVotesCount
      downVotesCount
      totalVotesCount
      mutation
    )
  end

  let(:expected_mutation_fields) do
    %w(
      update
      addTopic
      removeTopic
      addDataSet
      removeDataSet
      addDataReport
      removeDataReport
      voteUp
      voteDown
      follow
      unfollow
      createAnswer
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end
end
