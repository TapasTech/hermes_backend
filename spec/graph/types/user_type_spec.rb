# frozen_string_literal: true
require 'rails_helper'

RSpec.describe UserType, type: :model do
  let(:fields) { described_class.fields }
  let(:mutation_fields) { fields['mutation']&.type&.fields }
  let(:expected_fields) do
    %w(
      id
      createdAt
      updatedAt
      deletedAt
      email
      displayName
      description
      gender
      business
      location
      employment
      education
      followers
      followees
      followersCount
      followeesCount
      questions
      answers
      comments
      replyComments
      questionsCount
      answersCount
      dataSets
      dataReports
      upVotesCount
      downVotesCount
      activities
      mutation
    )
  end

  let(:expected_mutation_fields) do
    %w(
      update
      follow
      unfollow
    )
  end

  describe 'fields' do
    it 'are expected_fields' do
      expect(fields.keys).to contain_exactly(*expected_fields)
      expect(mutation_fields&.keys || []).to contain_exactly(*expected_mutation_fields)
    end
  end
end
